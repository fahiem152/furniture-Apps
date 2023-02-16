import 'package:flutter/material.dart';

import 'package:furniture/models/user_model.dart';
import 'package:furniture/services/user_services.dart';
import 'package:furniture/theme.dart';

class UserProvider with ChangeNotifier {
  UserService _userService = UserService();
  List<UserModel> _users = [];
  UserModel _user = UserModel(
    name: '',
    email: '',
    password: '',
  );

  List<UserModel> get users => _users;

  Future<void> fetchUser() async {
    try {
      _users = await _userService.fetchUser();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserModel user = await _userService.createUser(
        name: name,
        email: email,
        password: password,
      );
      _users.add(user);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser({
    required String name,
    required String email,
    required String password,
    required int id,
  }) async {
    try {
      UserModel user = await _userService.updateUser(
        name: name,
        email: email,
        password: password,
        id: id,
      );
      int index = _users.indexWhere((user) => user.id == id);
      if (index >= 0) {
        _users[index] = user;
        // notifyListeners();
        // return true;
      }
      // } else {
      //   return false;
      // }
      _user = user;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser({
    required int id,
  }) async {
    try {
      await _userService.deleteUser(id: id);
      _users.removeWhere((user) => user.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
