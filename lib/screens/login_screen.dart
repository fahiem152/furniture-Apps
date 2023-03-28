import 'package:flutter/material.dart';
import 'package:furniture/models/api_respone_model.dart';

import 'package:furniture/providers/auth_provider.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/services/storage_service.dart';

import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    void functionLoginUser() async {
      showAlertDialog(context);
      if (authProvider.valueRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please Select Role'),
          ),
        );
        Navigator.pop(context);
      } else {
        if (_key.currentState!.validate()) {
          ApiResponse loginResponse = await authProvider.login(
            email: emailController.text,
            password: passwordController.text,
            roleId: authProvider.valueRole!,
          );
          if (loginResponse.error == null) {
            await saveInfoUser();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Login Success'),
              ),
            );
            if (authProvider.valueRole == 1) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/admin', (route) => false);
            } else if (authProvider.valueRole == 2) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/kurir', (route) => false);
            } else if (authProvider.valueRole == 3) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/owner', (route) => false);
            } else if (authProvider.valueRole == 4) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/member', (route) => false);
            }
            authProvider.setValueRole(null);
            // if (authProvider.valueRole == 1) {
            //   Navigator.pushNamedAndRemoveUntil(
            //       context, '/admin', (route) => false);
            // } else if (authProvider.valueRole == 2) {
            //   Navigator.pushNamedAndRemoveUntil(context, '/user', (route) => false);
            // }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${loginResponse.error}'),
              ),
            );
            Navigator.pop(context);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email dan Password tidak boleh kosong'),
            ),
          );
          Navigator.pop(context);
          // Navigator.pop(context);
        }
      }
    }

    final roleList = Provider.of<RoleProvider>(context).roles;

    print('Jumlah Roles: ${roleList.length}');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Semarang, Indonesia",
                        style: textColor3.copyWith(
                          fontSize: 12,
                          fontWeight: bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    "Let’s Sign You In",
                    style: textColor3.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Welcome back, you’ve been missed!",
                    style: textColor3.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: textColor3.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: const BoxDecoration(),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Your Email",
                                    hintStyle: textColor3.copyWith(
                                      fontSize: 14,
                                      fontWeight: reguler,
                                    ),
                                  ),
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return "Email tidak boleh kosong";
                                    } else {
                                      return null;
                                    }
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Password',
                          style: textColor3.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.lock_outline),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: isPasswordVisible,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Your Password",
                                    hintStyle: textColor3.copyWith(
                                      fontSize: 14,
                                      fontWeight: reguler,
                                    ),
                                  ),
                                  validator: ((value) {
                                    if (value!.isEmpty) {
                                      return "Password tidak boleh kosong";
                                    } else {
                                      return null;
                                    }
                                  }),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Role',
                          style: textColor3.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.co_present_outlined),
                              const SizedBox(
                                width: 16,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  hint: Text('Select Role'),
                                  items: roleList
                                      .map((item) => DropdownMenuItem(
                                            value: item.id,
                                            child: Text(item.name),
                                          ))
                                      .toList(),
                                  onChanged: (newValue) {
                                    authProvider.setValueRole(
                                        int.parse(newValue.toString()));
                                    print(authProvider.valueRole.toString());
                                    // setState(() {
                                    //   valueRole = newValue;
                                    //   print(valueRole);
                                    // });
                                  },
                                  value: authProvider.valueRole,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: functionLoginUser,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: color4,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: textColor3.copyWith(
                                  fontSize: 16,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account? ',
                              style: textColor3.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            Text(
                              'Sign Up',
                              style: textColor3.copyWith(
                                fontSize: 12,
                                fontWeight: bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
