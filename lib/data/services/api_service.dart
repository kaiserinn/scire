import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scire/data/services/models/auth/auth_response.dart';
import 'package:scire/utils/result.dart';

class ApiService {
  ApiService({String? host, int? port, http.Client? client})
    : _host = host ?? "localhost",
      _port = port ?? 7878,
      _client = client ?? http.Client();

  static const _baseUrl = "/api";

  final String _host;
  final int _port;
  final http.Client _client;

  Future<Result<AuthResponse>> login(String email, String password) async {
    final uri = Uri.http("$_host:$_port", "$_baseUrl/auth/login");
    final response = await _client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user": {"email": email, "password": password},
      }),
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("failed to login"));
    }

    final user = AuthResponse.fromJson(jsonDecode(response.body));
    return Result.ok(user);
  }

  Future<Result<AuthResponse>> register(
    String username,
    String email,
    String password,
  ) async {
    final uri = Uri.http("$_host:$_port", "$_baseUrl/auth/register");
    final response = await _client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user": {"username": username, "email": email, "password": password},
      }),
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("failed to register"));
    }

    final user = AuthResponse.fromJson(jsonDecode(response.body));
    return Result.ok(user);
  }

  void dispose() {
    _client.close();
  }
}
