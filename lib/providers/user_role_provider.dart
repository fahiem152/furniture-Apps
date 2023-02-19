import 'package:flutter/material.dart';
import 'package:furniture/models/user_role_model.dart';
import 'package:furniture/services/user_role_service.dart';

class UserRoleProvider with ChangeNotifier {
  UserRoleService _userRoleService = UserRoleService();
  List<UserRoleModel> _userRoles = [];
  UserRoleModel _userRole = UserRoleModel(authRoleId: 0, authUserId: 0);
  int? _userId;
  int? _roleId;

  List<UserRoleModel> get userRoles => _userRoles;
  int? get userId => _userId;
  int? get roleId => _roleId;

  void setUserId(int? newValue) {
    _userId = newValue;
    notifyListeners();
  }

  void setRoleId(int? newValue) {
    _roleId = newValue;
    notifyListeners();
  }

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
        authUserId: authUserId,
        authRoleId: authRoleId,
      );
      _userRole = userRole;
      _userRoles.add(_userRole);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: $e");
      return false;
    }
  }

  Future<bool> updateUserRole({
    required int id,
    required int authUserId,
    required int authRoleId,
  }) async {
    try {
      UserRoleModel userRole = await _userRoleService.updateUserRole(
        id: id,
        authUserId: authUserId,
        authRoleId: authRoleId,
      );
      _userRole = userRole;
      _userRoles.add(_userRole);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: $e");
      return false;
    }
  }

  Future<bool> deleteUserRole({
    required int id,
  }) async {
    try {
      await _userRoleService.deleteUserRole(id: id);
      _userRoles.removeWhere((userRole) => userRole.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print("error: $e");
      return false;
    }
  }
}
