import 'dart:convert';
import 'package:cps_mobile/core/constants/constants.dart';
import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/models/user_response.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserResponse> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserResponse> getUsers() async {
    final response = await client.get(
      Uri.parse('$baseUrl/user'),
    );

    String data = '{"users": ${response.body}}';

    if (response.statusCode == 200) {
      return UserResponse.fromJson(json.decode(data));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }
}