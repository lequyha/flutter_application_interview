import 'package:flutter/material.dart';
import 'package:flutter_application_interview/src/models/user_model.dart';

class UserForm extends StatefulWidget {
  final UserModel? user;
  final ValueChanged<String> onChanged;
  const UserForm({super.key, required this.onChanged, this.user});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.user != null) {
      _controller.text = widget.user?.name ?? '';
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Trường bắt buộc';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onChanged(_controller.text);
                  }
                },
                child: Text(
                  widget.user != null
                      ? 'Chỉnh sửa người dùng'
                      : 'Tạo mới người dùng',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
