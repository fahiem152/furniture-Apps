import 'package:flutter/material.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';

class ProfileAdminScreen extends StatelessWidget {
  const ProfileAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => AuthService().logout().then(
            (value) => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false,
            ),
          ),
      child: Text('Logout'),
    );
  }
}
