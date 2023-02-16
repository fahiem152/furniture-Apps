import 'package:flutter/material.dart';
import 'package:furniture/models/login_respone.dart';
import 'package:furniture/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  Future<LoginResponeModel> login(
    String email,
    String password,
    int roleId,
  ) async {
    final loginResponse = await _authService.login(email, password, roleId);
    return loginResponse;
  }

  Future<void> logout() async {
    notifyListeners();
  }
}
