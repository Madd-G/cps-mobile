import 'dart:convert';
import 'package:cps_mobile/core/constants/constants.dart';
import 'package:cps_mobile/core/errors/errors.dart';
import 'package:cps_mobile/src/data/models/city_response.dart';
import 'package:http/http.dart' as http;

abstract class CityRemoteDataSource {
  Future<CityResponse> getCities();
}

class CityRemoteDataSourceImpl implements CityRemoteDataSource {
  final http.Client client;

  CityRemoteDataSourceImpl({required this.client});

  @override
  Future<CityResponse> getCities() async {
    final response = await client.get(Uri.parse('$baseUrl/city'));

    String data = '{"cities": ${response.body}}';

    if (response.statusCode == 200) {
      return CityResponse.fromJson(json.decode(data));
    } else {
      throw ServerException('Failed to connect to the server');
    }
  }
}
