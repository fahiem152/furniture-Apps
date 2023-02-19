import 'package:flutter/material.dart';
import 'package:furniture/models/role_model.dart';
import 'package:furniture/services/role_service.dart';

class RoleProvider with ChangeNotifier {
  RoleService _roleService = RoleService();
  List<RoleModel> _roles = [];
  // String _selectedRole = '';
  RoleModel _role = RoleModel(name: '');

  List<RoleModel> get roles => _roles;
  // String get selectedRole => _selectedRole;
  // RoleModel get role => _role;

  // set selectedRole(String newRole) {
  //   _selectedRole = newRole;
  //   notifyListeners();
  // }

  // bool isRoleNameAvailable(String name) {
  //   return !_roles.contains(name);
  //   // bool isAvailable = true;
  //   // _roles.forEach((role) {
  //   //   if (role.name == name) {
  //   //     isAvailable = false;
  //   //   }
  //   // });
  //   // return isAvailable;
  // }

  Future<void> fetchRole() async {
    try {
      _roles = await _roleService.fetchRole();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Future<void> fetchRoleById(int id) async {
  //   try {
  //     _roles = await _roleService.fetchRoleById(id);
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<bool> createRole({
    required String name,
  }) async {
    try {
      RoleModel role = await _roleService.createRole(name: name);
      _role = role;
      _roles.add(_role);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateRole({
    required String name,
    required int id,
  }) async {
    try {
      RoleModel role = await _roleService.updateRole(name: name, id: id);
      int index = _roles.indexWhere((role) => role.id == id);
      if (index >= 0) {
        _roles[index] = role;
      }

      _role = role;
      // _roles.add(_role);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteRole({required int id}) async {
    try {
      await _roleService.deleteRole(id: id);
      _roles.removeWhere((role) => role.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
