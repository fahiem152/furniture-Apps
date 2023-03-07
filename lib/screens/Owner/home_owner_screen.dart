import 'package:flutter/material.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/services/auth_service.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:furniture/theme.dart';

class HomeOwnerScreen extends StatefulWidget {
  const HomeOwnerScreen({super.key});

  @override
  State<HomeOwnerScreen> createState() => _HomeOwnerScreenState();
}

class _HomeOwnerScreenState extends State<HomeOwnerScreen> {
  String name = '';
  String role = '';
  @override
  void initState() {
    super.initState();
    loadInfoUser();
  }

  loadInfoUser() async {
    name = await getName();
    role = await getRole();
  }

  @override
  Widget build(BuildContext context) {
    Widget headerAdmin() {
      return Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(
              'assets/images/logo.jpg',
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Text(
                  name == '' ? 'Name' : name,
                  style: textColor3.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Text(
                role == ''
                    ? 'Role'
                    : role == '3'
                        ? 'Owner'
                        : 'Role Unknown',
                style: textColor3.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              )
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () => AuthService().logout().then(
                  (value) => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  ),
                ),
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: color5,
            iconSize: 30,
          )
        ],
      );
    }

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerAdmin(),
              Container(
                color: Colors.red,
                width: double.infinity,
                height: 600,
              )
            ],
          ),
        ),
      ),
    );
  }
}
