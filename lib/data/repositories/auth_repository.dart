import 'package:flutter/foundation.dart';

import '../app_exception.dart';
import '../models/auth_models.dart';
import '../services/auth_service.dart';

class AuthRepository {
  AuthRepository(this.service);

  final AuthService service;

  String? accessToken;
  String? refreshToken;
  int minutes = 60;

  Future<void> login(String username, String password, int tokenMinutes) async {
    final tokens = await service.login(username, password, tokenMinutes);
    accessToken = tokens.accessToken;
    refreshToken = tokens.refreshToken;
    minutes = tokenMinutes;
    debugPrint('Access token: $accessToken');
  }

  Future<User> getUser() async {
    try {
      return await service.getMe(accessToken!);
    } on UnauthorizedException {
      debugPrint('401 – access token je istekao, osvježavam ga');
      final tokens = await service.refresh(refreshToken!, minutes);
      accessToken = tokens.accessToken;
      refreshToken = tokens.refreshToken;
      debugPrint('Token osvježen');
      return await service.getMe(accessToken!);
    }
  }

  void logout() {
    accessToken = null;
    refreshToken = null;
  }
}