import 'dart:convert';

import 'package:furniture/models/user_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _baseUrl = '${baseUrl}/api/users';

  Future<List<UserModel>> fetchUser() async {
    var response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      // print(data);
      return data.map<UserModel>((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<UserModel> createUser(
      {required String name,
      required String email,
      required String password}) async {
    var response = await http.post(Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
            "email": email,
            "password": password,
          },
        ));
    print(response.body);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return UserModel.fromJson(data);
    } else if (response.statusCode == 422) {
      throw Exception('Email already exists');
    } else {
      throw Exception('Failed Create User');
    }
  }

  Future<UserModel> updateUser({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    var response = await http.put(Uri.parse('$_baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
            "email": email,
            "password": password,
          },
        ));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed Update User');
    }
  }

  Future<void> deleteUser({required int id}) async {
    var response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      print('Delete Success');
    } else {
      throw Exception('Failed Delete User');
    }
  }
}
