import 'package:flutter/material.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/providers/user_role_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddUserRole extends StatefulWidget {
  const AddUserRole({super.key});

  @override
  State<AddUserRole> createState() => _AddUserRoleState();
}

class _AddUserRoleState extends State<AddUserRole> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var valueRole;
  var valueUser;
  // int valueUser = 0;
  // int valueRole = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    Provider.of<RoleProvider>(context, listen: false).fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final roleProvider = Provider.of<RoleProvider>(context);
    final userRoleProvider = Provider.of<UserRoleProvider>(context);
    handleCreateUserRole() async {
      setState(() {
        isLoading = true;
      });
      if (await userRoleProvider.createUserRole(
        // user_id: valueUser, role_id: valueRole
        authUserId: int.parse(valueUser),
        authRoleId: int.parse(valueRole),
      )) {
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color5,
          content: Text(
            'Gagal Untuk Create User Role',
            style: textColor1.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ));
      }
      print('Role id: ${valueRole.toString()}' +
          " User id: ${valueUser.toString()}");
      setState(() {
        isLoading = false;
      });
    }

    add() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleCreateUserRole();
      }
    }

    PreferredSize getAppbar() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: color3),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: color1,
          centerTitle: true,
          elevation: 1,
          title: Text(
            "Add User Role",
            style: textColor3.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
        ),
      );
    }

    Widget getBody() {
      return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: defaultMargin),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: color5, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    hint: Text(
                      'Select User',
                    ),
                    items: userProvider.users.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.name),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        valueUser = newValue;
                        print(valueUser);
                      });
                    },
                    value: valueUser,
                  )),
                ),
                Container(
                  margin: EdgeInsets.only(top: defaultMargin),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: color5, width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                    hint: Text(
                      'Select Role',
                    ),
                    items: roleProvider.roles.map((item) {
                      return DropdownMenuItem(
                        child: Text(item.name),
                        value: item.id.toString(),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        valueRole = newValue;
                        print(valueRole);
                      });
                    },
                    value: valueRole,
                  )),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: add,
                        child: Container(
                          margin: EdgeInsets.only(top: defaultMargin),
                          height: 50,
                          decoration: BoxDecoration(
                            color: color4,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Add User Role",
                              style: textColor3.copyWith(
                                fontSize: 16,
                                fontWeight: bold,
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ));
    }

    return Scaffold(
      backgroundColor: color1,
      appBar: getAppbar(),
      body: getBody(),
    );
  }
}