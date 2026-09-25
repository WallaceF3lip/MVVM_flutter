//flutter pub add dio --> PACOKAGE PARA REALIZAR REQUISIÇÃO HTTP
import 'package:app_mvvm/data/service/api/models/login_request.dart';
import 'package:app_mvvm/data/service/api/models/login_response.dart';
import 'package:app_mvvm/utils/result.dart';
import 'package:dio/dio.dart';

class ApiClient {
  final String _apiUrl;
  final Dio _dio;

  const ApiClient({required String apiUrl, required Dio dio})
      : _apiUrl = apiUrl,
        _dio = dio;

  Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
    try {
      final endpoint = "$_apiUrl/auth/login";
      
      final response = await _dio.post(endpoint, data: loginRequest.toJson());
      
      if(response.statusCode == 200) {
        final result = LoginResponse.fromJson(response.data);
        return Result.ok(result);
      }

      return Result.erro(Exception('Erro ao realizar login'));
      
    } on Exception catch (error) {
      return Result.erro(error);
    }
  }
}