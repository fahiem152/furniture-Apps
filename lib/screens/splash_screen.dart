import 'dart:async';

import 'package:flutter/material.dart';
import 'package:furniture/models/role_model.dart';
import 'package:furniture/providers/auth_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/screens/Admin/main_admin_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/services/role_service.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dart_jwt/dart_jwt.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void loadUserInfo() async {
    await Future.delayed(Duration(milliseconds: 1000));
    String token = await getToken();
    // final _tokenExpired = Duration(hours: 6);
    // final time = DateTime.now();
    print('ini adalah token: ' + token);

    if (token == '') {
      Navigator.pushNamed(context, '/login');
    }
    // else if (time == _tokenExpired) {
    //   Navigator.pushNamed(context, '/login');
    // }
    else {
      final Map<String, dynamic> decodedToken =
          await AuthService.getDecodedToken(token);

      print("decodedToken : " + decodedToken.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', decodedToken['id'].toString());
      prefs.setString('role_id', decodedToken['role_id'].toString());
      prefs.setString('name', decodedToken['name'].toString());

      // print("UserId: " + decodedToken['id'].toString());
      print("UserId:  ${prefs.getString('id')}");
      print("Name:  ${prefs.getString('name')}");
      print("RoleId:  ${prefs.getString('role_id')}");
      print("decodedToken['role_id'] : " + decodedToken['role_id'].toString());
      if (decodedToken['role_id'] == 1) {
        Navigator.pushNamedAndRemoveUntil(context, '/admin', (route) => false);
      } else if (decodedToken['role_id'] == 2) {
        Navigator.pushNamedAndRemoveUntil(context, '/kurir', (route) => false);
      } else if (decodedToken['role_id'] == 3) {
        Navigator.pushNamedAndRemoveUntil(context, '/owner', (route) => false);
      }
    }
  }

  splashScreenStart() async {
    var duration = Duration(seconds: 3);

    return Timer(duration, () {
      setState(() {
        loadUserInfo();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    splashScreenStart();
  }

  // getInt() async {
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // await Provider.of<BrandProvider>(context, listen: false).getBrands();
  //   // await Provider.of<CategoryProvider>(context, listen: false).geCategorys();
  //   await Provider.of<ProductProvider>(context, listen: false).getProducts();
  //   Navigator.pushNamed(context, '/login');
  // }

  @override
  Widget build(BuildContext context) {
    // final roleList = Provider.of<RoleProvider>(context).roles;
    // print(roleList);
    return Scaffold(
        body: Center(
      child: Text(
        'Furniture Apps',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: color4,
        ),
      ),
    ));
  }
}
