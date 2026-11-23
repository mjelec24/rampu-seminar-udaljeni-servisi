import 'package:flutter/foundation.dart';

import '../../data/repositories/auth_repository.dart';
import '../error_message.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this.repository);

  final AuthRepository repository;

  bool isLoading = false;
  String? error;

  Future<bool> login(String username, String password, int minutes) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await repository.login(username, password, minutes);
      return true;
    } catch (e) {
      final message = errorText(e);
      error = message.contains('400') ? 'Neispravno korisničko ime ili lozinka.' : message;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}