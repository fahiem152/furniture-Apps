import 'package:flutter/material.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';

class HomeKurirScreen extends StatelessWidget {
  const HomeKurirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Kurir'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('HomePage Role Kurir'),
          ElevatedButton(
            onPressed: () => AuthService().logout().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  ),
                ),
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
