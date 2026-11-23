import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api.dart';
import '../models/auth_models.dart';

class AuthService {
  static const baseUrl = 'https://dummyjson.com/auth';

  Future<Tokens> login(String username, String password, int minutes) async {
    final json = await sendRequest(http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': minutes,
      }),
    ));
    return Tokens.fromJson(json);
  }

  Future<User> getMe(String accessToken) async {
    final json = await sendRequest(http.get(
      Uri.parse('$baseUrl/me'),
      headers: {'Authorization': 'Bearer $accessToken'},
    ));
    return User.fromJson(json);
  }

  Future<Tokens> refresh(String refreshToken, int minutes) async {
    final json = await sendRequest(http.post(
      Uri.parse('$baseUrl/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken, 'expiresInMins': minutes}),
    ));
    return Tokens.fromJson(json);
  }
}