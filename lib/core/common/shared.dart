import 'package:http/http.dart' as http;

class ApiService {
  final http.Client _httpClient;
  static const String baseUrl =
      'https://627e360ab75a25d3f3b37d5a.mockapi.io/api/v1/accurate';

  static final ApiService _instance = ApiService._internal(http.Client());

  factory ApiService() => _instance;

  ApiService._internal(this._httpClient);

  http.Client get client => _httpClient;
}
