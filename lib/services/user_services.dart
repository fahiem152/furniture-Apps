// import 'dart:convert';

// import 'package:furniture/models/product_model.dart';
// import 'package:furniture/models/user_model.dart';
// import 'package:http/http.dart' as http;

// class UserServices {
//   String baseUrl = 'https://reqres.in/api';



//   Future<List<UserModel>> getUsers() async {
//     var url = '$baseUrl/users?page=2';
  
//     var response = await http.get(Uri.parse(url));
//     print('ini adalahresponse.body: ${response.body}');
//     List data = jsonDecode(response.body)['data'];
//     List<UserModel> users = [];
//     for (var item in data) {
//       users.add(UserModel.fromJson(item));
//     }
//     print('ini get datausers $users');
//     return users;

//     // if (response.statusCode == 200) {
//     //   List data = jsonDecode(response.body);
//     //   List<UserModel> users = [];
//     //   for (var item in data) {
//     //     users.add(UserModel.fromJson(item));
//     //   }
//     //   print('ini get datausers $users');
//     //   return users;
//     // } else {
//     //   throw Exception('Gagal Get USers!');
//     // }
//   }
// }
