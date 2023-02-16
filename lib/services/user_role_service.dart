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
            "user_id": authUserId,
            "role_id": authRoleId,
          },
        ));
    print('ini adalah resppoonse:${response.body}');
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return UserRoleModel.fromJson(data);
    } else {
      throw Exception('Failed Create UserRole');
    }
  }
}
