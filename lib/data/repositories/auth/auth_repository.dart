import 'package:scire/data/services/api_service.dart';
import 'package:scire/data/services/models/auth/auth_response.dart';
import 'package:scire/utils/result.dart';

class AuthRepository {
  AuthRepository({required ApiService apiService}) : _apiService = apiService;

  final ApiService _apiService;

  Future<Result<AuthResponse>> login(String email, String password) async {
    return await _apiService.login(email, password);
  }

  Future<Result<AuthResponse>> register(
    String username,
    String email,
    String password,
  ) async {
    return await _apiService.register(username, email, password);
  }
}
