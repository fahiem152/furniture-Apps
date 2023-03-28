import 'dart:convert';

import 'package:furniture/models/login_respone.dart';

import 'package:furniture/services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_respone_model.dart';

class AuthService {
  final String _baseUrl = '$baseUrl/api/login';

  Future<ApiResponse> login({
    required String email,
    required String password,
    required int roleId,
  }) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(
        Uri.parse(
          _baseUrl,
        ),
        body: {
          'email': email,
          'password': password,
          'role_id': "$roleId",
        },
      );
      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body)['data'];
          final loginResponse = LoginResponeModel.fromJson(jsonData);
          apiResponse.data = loginResponse;
          // save token to shared preferences
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', loginResponse.token!);
          print(prefs.getString('token'));
          // return apiResponse;
          break;
        case 401:
          apiResponse.error = jsonDecode(response.body)['error'];
          // return apiResponse;
          break;
        case 404:
          apiResponse.error = jsonDecode(response.body)['error'];
          break;
        case 400:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = somethingWhentWrong;
          break;
      }
    } catch (e) {
      apiResponse.error = 'Server Error';
    }
    return apiResponse;
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
