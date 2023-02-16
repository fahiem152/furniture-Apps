import 'dart:convert';
import 'dart:math';

import 'package:furniture/models/role_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:http/http.dart' as http;

class RoleService {
  final String _baseUrl = '${baseUrl}/api/roles';
  Future<List<RoleModel>> fetchRole() async {
    var response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data.map<RoleModel>((json) => RoleModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<RoleModel> fetchRoleById(int id) async {
  //   var response = await http.get(Uri.parse('$_baseUrl/$id'));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body)['data'];
  //     return RoleModel.fromJson(data);
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  Future<RoleModel> createRole({
    required String name,
  }) async {
    var response = await http.post(Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
          },
        ));
    print(response.body);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return RoleModel.fromJson(data);
    } else {
      throw Exception('Failed Create Role');
    }
  }

  Future<RoleModel> updateRole({required String name, required int id}) async {
    var response = await http.put(Uri.parse('$_baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "name": name,
          },
        ));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return RoleModel.fromJson(data);
    } else {
      throw Exception('Failed Update Role');
    }
  }

  Future<void> deleteRole({required int id}) async {
    var response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      print('Delete Success');
    } else {
      throw Exception('Failed Delete Role');
    }
  }
}
