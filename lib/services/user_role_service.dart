import 'dart:convert';

import 'package:furniture/models/user_role_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:http/http.dart' as http;

class UserRoleService {
  final String _baseUrl = '${baseUrl}/api/userRoles';

  Future<List<UserRoleModel>> fetchUserRole() async {
    var response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];

      return data
          .map<UserRoleModel>((json) => UserRoleModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<UserRoleModel> createUserRole({
    required int authUserId,
    required int authRoleId,
  }) async {
    var response = await http.post(Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "user_id": authUserId.toString(),
            "role_id": authRoleId.toString(),
          },
        ));
    print('ini adalah resppoonse:${response.body}');
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      print('Data USer ROle: $data');
      return UserRoleModel.fromJson(data);
    } else {
      throw Exception('Failed Create UserRole');
    }
  }

  Future<UserRoleModel> updateUserRole({
    required int authUserId,
    required int authRoleId,
    required int id,
  }) async {
    var response = await http.put(Uri.parse('$_baseUrl/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "user_id": authUserId.toString(),
            "role_id": authRoleId.toString(),
          },
        ));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return UserRoleModel.fromJson(data);
    } else {
      throw Exception('Failed Update UserRole');
    }
  }

  Future<void> deleteUserRole({required int id}) async {
    var response = await http.delete(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode == 200) {
      print('Delete Success');
    } else {
      throw Exception('Failed Delete UserRole');
    }
  }
}
