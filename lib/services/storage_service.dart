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
