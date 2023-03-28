import 'package:flutter/material.dart';
import 'package:furniture/models/api_respone_model.dart';
import 'package:furniture/models/login_respone.dart';
import 'package:furniture/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  int? _valueRole;
  int? get valueRole => _valueRole;

  void setValueRole(int? newValue) {
    _valueRole = newValue;
    notifyListeners();
  }

  Future<ApiResponse> login({
    required String email,
    required String password,
    required int roleId,
  }) async {
    final loginResponse = await _authService.login(
        email: email, password: password, roleId: roleId);
    return loginResponse;
  }
}
