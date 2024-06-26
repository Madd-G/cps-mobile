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

  Future<UserResponse> getFilteredUsers({required String city});

  Future<UserResponse> getSortedUsers({required String sort});

  Future<void> updateUser(
      {required String userId, required UserModel user});

  Future<UserResponse> deleteUserRemote(String userId);
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
    } else if (response.statusCode == 404) {
      throw ServerException('No user found');
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<UserResponse> getFilteredUsers({required String city}) async {
    final response = await client.get(Uri.parse('$baseUrl/user?city=$city'));

    String data = '{"users": ${response.body}}';

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(data));
    } else if (response.statusCode == 404) {
      throw ServerException('No user found');
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<UserResponse> getSortedUsers({required String sort}) async {
    final response =
        await client.get(Uri.parse('$baseUrl/user?sortBy=name&order=$sort'));

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
    } else if (response.statusCode == 404) {
      throw ServerException('No user found');
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }

  @override
  Future<void> addUser({
    required UserModel user,
  }) async {
    try {
      await client.post(
        Uri.parse('$baseUrl/user'),
        body: user.toJsonWithoutId(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateUser({
    required String userId,
    required UserModel user,
  }) async {
    try {
      await client.put(
        Uri.parse('$baseUrl/user/$userId'),
        body: user.toJsonWithoutId(),
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserResponse> deleteUserRemote(String userId) async {
    await client.delete(Uri.parse('$baseUrl/user/$userId'));
    final response = await client.get(Uri.parse('$baseUrl/user'));
    String data = '{"users": ${response.body}}';
    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(data));
    } else if (response.statusCode == 404) {
      throw ServerException('No user found');
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }
}
