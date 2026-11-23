import 'package:flutter/foundation.dart';

import '../../data/models/auth_models.dart';
import '../../data/repositories/auth_repository.dart';
import '../error_message.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel(this.repository) {
    load();
  }

  final AuthRepository repository;

  bool isLoading = false;
  String? error;
  User? user;

  String get accessToken => repository.accessToken ?? '-';

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      user = await repository.getUser();
    } catch (e) {
      error = errorText(e);
    }

    isLoading = false;
    notifyListeners();
  }

  void logout() => repository.logout();
}