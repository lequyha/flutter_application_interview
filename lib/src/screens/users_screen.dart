import 'package:flutter/material.dart';
import 'package:flutter_application_interview/src/models/user_model.dart';
import 'package:flutter_application_interview/src/repositories/user_repository.dart';
import 'package:flutter_application_interview/src/screens/components/user_form.dart';
import 'package:flutter_package_interview/flutter_package_interview.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final usersState = StateManager<List<UserModel>>([]);
  final loadingState = StateManager<bool>(false);

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    loadingState.setState(true);
    await usersState.setAsync(() async => await UserRepository().fetchUsers());
    loadingState.setState(false);
  }

  Future<void> _deleteUser(UserModel user) async {
    loadingState.setState(true);
    final isSuccess = await UserRepository().deleteUser(user: user);
    if (isSuccess) usersState.removeItem(user);
    loadingState.setState(false);
  }

  Future<void> _createUser(String name) async {
    loadingState.setState(true);
    final newUser = await UserRepository().createUser(name: name);
    usersState.addItem(newUser);
    loadingState.setState(false);
  }

  Future<void> _updateUser(UserModel user, String newName) async {
    loadingState.setState(true);
    final updatedUser = await UserRepository().updateUser(
      user: user,
      newName: newName,
    );
    usersState.updateItem((u) => u.id == updatedUser.id, updatedUser);
    loadingState.setState(false);
  }

  Future<void> _openUserForm({UserModel? user}) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder:
          (context) => UserForm(
            user: user,
            onChanged: (value) => Navigator.pop(context, value),
          ),
    );

    if (result?.isNotEmpty == true) {
      user == null
          ? await _createUser(result!)
          : await _updateUser(user, result!);
    }
  }

  @override
  void dispose() {
    usersState.dispose();
    loadingState.dispose();
    super.dispose();
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StateListener<bool>(
      stateManager: loadingState,
      listener: (context, isLoading) {
        if (isLoading) {
          showLoadingDialog(context);
        } else {
          hideLoadingDialog(context);
        }
      },
      listenWhen: (previous, current) => current != previous,
      child: Scaffold(
        body: SafeArea(
          child: StateBuilder<List<UserModel>>(
            stateManager: usersState,
            builder:
                (context, list) =>
                    list.isEmpty
                        ? Center(
                          child: Text('Chưa có người dùng nào vui lòng tạo'),
                        )
                        : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            final user = list[index];
                            return ListTile(
                              key: ValueKey(user.id),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt),
                              leading: Image.network(user.avatar),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _openUserForm(user: user),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteUser(user),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openUserForm(),
          tooltip: 'Thêm',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
