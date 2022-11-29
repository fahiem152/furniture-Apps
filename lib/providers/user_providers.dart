// import 'package:flutter/material.dart';
// import 'package:furniture/models/product_model.dart';
// import 'package:furniture/models/user_model.dart';
// import 'package:furniture/services/product_services.dart';
// import 'package:furniture/services/user_services.dart';

// class UserProvider with ChangeNotifier {
//   List<UserModel> _users = [];

//   List<UserModel> get users => _users;

//   set users(List<UserModel> users) {
//     _users = users;
//     notifyListeners();
//   }

//   Future<void> getUsers() async {
//     try {
//       List<UserModel> users = await UserServices().getUsers();
//       _users = users;
//     } catch (e) {
//       print(e);
//     }
//   }
// }
