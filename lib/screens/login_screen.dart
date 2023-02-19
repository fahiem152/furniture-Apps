import 'package:flutter/material.dart';

import 'package:furniture/providers/auth_provider.dart';
import 'package:furniture/providers/role_provider.dart';

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
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).fetchRole();
  }

  // var valueRole;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleLogin() async {
      setState(() {
        isLoading = true;
      });
      if (_key.currentState!.validate()) {
        final loginResponse = await authProvider.login(
          emailController.text,
          passwordController.text,
          authProvider.valueRole!,
        );
        if (loginResponse != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Success'),
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
          }

          // Navigator.pushNamedAndRemoveUntil(
          //     context, '/admin', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Failed'),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login Failed'),
          ),
        );
        Navigator.pop(context);
      }
      setState(() {
        isLoading = false;
      });
    }

    final roleList = Provider.of<RoleProvider>(context).roles;
    // var selectedRole = Provider.of<RoleProvider>(context).selectedRole;

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
                        isLoading
                            ? CircularProgressIndicator()
                            : GestureDetector(
                                onTap: handleLogin,
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
