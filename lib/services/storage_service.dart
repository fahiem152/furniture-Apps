import 'package:furniture/services/auth_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

Future<String> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('id') ?? '';
}

Future<String> getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('role_id') ?? '';
}

Future<String> getName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('name') ?? '';
}

saveInfoUser() async {
  String token = await getToken();
  final Map<String, dynamic> decodedToken =
      await AuthService.getDecodedToken(token);

  print("decodedToken : " + decodedToken.toString());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('id', decodedToken['id'].toString());
  prefs.setString('role_id', decodedToken['role_id'].toString());
  prefs.setString('name', decodedToken['name'].toString());
}

cekToken() async {
  String token = await getToken();
  bool isExpired = Jwt.isExpired(token);
  if (isExpired) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    return token = '';
  }
  return token;
}
