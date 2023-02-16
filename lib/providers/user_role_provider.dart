import 'package:flutter/material.dart';
import 'package:furniture/models/user_role_model.dart';
import 'package:furniture/services/user_role_service.dart';

class UserRoleProvider with ChangeNotifier {
  UserRoleService _userRoleService = UserRoleService();
  List<UserRoleModel> _userRoles = [];
  UserRoleModel _userRole = UserRoleModel(authRoleId: 0, authUserId: 0);

  List<UserRoleModel> get userRoles => _userRoles;

  Future<void> fetchUserRole() async {
    try {
      _userRoles = await _userRoleService.fetchUserRole();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createUserRole({
    required int authUserId,
    required int authRoleId,
  }) async {
    try {
      UserRoleModel userRole = await _userRoleService.createUserRole(
          authUserId: authUserId, authRoleId: authRoleId);
      _userRole = userRole;
      _userRoles.add(_userRole);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
