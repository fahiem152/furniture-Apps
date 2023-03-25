import 'dart:convert';

import 'package:furniture/models/login_respone.dart';

import 'package:furniture/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = '$baseUrl/api/login';

  Future<LoginResponeModel> login(
    String email,
    String password,
    int roleId,
  ) async {
    // LoginResponeModel loginResponse = LoginResponeModel(
    //   token: '',
    //   error: '',
    // );
    try {
      final response = await http.post(
        Uri.parse(
          _baseUrl,
        ),
        // headers: {
        //   'Content-Type': 'application/json',
        // },
        body: {
          'email': email,
          'password': password,
          'role_id': "$roleId",
        },
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data'];
        final loginResponse = LoginResponeModel.fromJson(jsonData);

        // save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', loginResponse.token!);

        print(prefs.getString('token'));
        return loginResponse;
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
        // final jsonData = json.decode(response.body);
        // final loginResponse = LoginResponeModel.fromJson(jsonData['error']);
        // return loginResponse.error == null
        //     ? LoginResponeModel(error: 'Something went wrong')
        //     : loginResponse;
      } else {
        throw Exception('Something went wrong');
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<bool> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
    // return preferences.remove('token');
  }

  static Future<Map<String, dynamic>> getDecodedToken(String token) async {
    final decoded = Jwt.parseJwt(token);
    final Map<String, dynamic> data = decoded;
    // final Map<String, dynamic> decodedToken =
    //     await AuthService.getDecodedToken(token);
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString('id', decodedToken['id'].toString());
    // prefs.setString('role_id', decodedToken['role_id'].toString());
    // prefs.setString('name', decodedToken['name'].toString());
    print('getDecodedToken : ' + data.toString());
    return data;
  }
  // bool isTokenExpired(String token) {
  //   final decoded = Jwt.parseJwt(token);
  //   final Map<String, dynamic> data = decoded;
  //   final exp = data['exp'];
  //   final now = DateTime.now().millisecondsSinceEpoch / 1000;
  //   return now > exp;
  // }
}
