import 'package:dio/dio.dart';

import 'api_client.dart';

class ApiService {
  final client = ApiClient.dio;

  Future<Response<List<dynamic>>> getAll(String path) async {
    try {
      final response = await client.get<List<dynamic>>(path);
      return response;
    } on DioException catch (error) {
      throw Exception(error);
    }
  }

  Future<Response<Map<String, dynamic>>> post({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await client.post<Map<String, dynamic>>(
        path,
        data: data,
      );
      return response;
    } on DioException catch (error) {
      throw Exception(error);
    }
  }

  Future<Response<Map<String, dynamic>>> put({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await client.put<Map<String, dynamic>>(path, data: data);
      return response;
    } on DioException catch (error) {
      throw Exception(error);
    }
  }

  Future<Response<Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await client.delete<Map<String, dynamic>>(
        path,
        data: data,
      );
      return response;
    } on DioException catch (error) {
      throw Exception(error);
    }
  }
}
