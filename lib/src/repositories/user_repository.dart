import 'package:flutter_application_interview/src/models/user_model.dart';
import 'package:flutter_package_interview/flutter_package_interview.dart';

class UserRepository {
  final _api = ApiService();

  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _api.getAll('/users');
      return response.data?.map((e) => UserModel.fromJson(e)).toList() ?? [];
    } on Exception {
      rethrow;
    }
  }

  Future<UserModel> createUser({required String name}) async {
    try {
      final response = await _api.post(path: '/users', data: {'name': name});
      if (response.data != null) {
        return UserModel.fromJson(response.data!);
      } else {
        throw Exception('Định dang user không đúng');
      }
    } on Exception {
      rethrow;
    }
  }

  Future<UserModel> updateUser({
    required UserModel user,
    required String newName,
  }) async {
    try {
      final response = await _api.put(
        path: '/users/${user.id}',
        data: {'name': newName},
      );
      if (response.data != null) {
        return UserModel.fromJson(response.data!);
      } else {
        throw Exception('Định dang user không đúng');
      }
    } on Exception {
      rethrow;
    }
  }

  Future<bool> deleteUser({required UserModel user}) async {
    try {
      final response = await _api.delete(path: '/users/${user.id}');
      return response.statusCode == 200;
    } on Exception {
      rethrow;
    }
  }
}
