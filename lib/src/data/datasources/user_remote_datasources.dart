import 'dart:convert';
import 'package:cps_mobile/core/constants/constants.dart';
import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/models/user_model.dart';
import 'package:cps_mobile/src/data/models/user_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserResponse> getUsers();

  Future<UserResponse> searchUsers(String query);

  Future<void> addUser({required UserModel user});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserResponse> getUsers() async {
    final response = await client.get(Uri.parse('$baseUrl/user'));

    String data = '{"users": ${response.body}}';

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(data));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<UserResponse> searchUsers(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/user?name=$query'));
    String data = '{"users": ${response.body}}';
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(data));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<void> addUser({
    required UserModel user,
  }) async {
    try {
      await client.post(Uri.parse('$baseUrl/user'), body: user.toJsonAddUser());
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(e.toString());
    }
  }
}
