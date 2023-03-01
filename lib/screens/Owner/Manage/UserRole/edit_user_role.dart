import 'package:flutter/material.dart';
import 'package:furniture/models/user_role_model.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/providers/user_role_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditUserRole extends StatefulWidget {
  UserRoleModel userRole;
  EditUserRole({super.key, required this.userRole});

  @override
  State<EditUserRole> createState() => _EditUserRoleState();
}

class _EditUserRoleState extends State<EditUserRole> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    Provider.of<RoleProvider>(context, listen: false).fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    final userRoleProvider = Provider.of<UserRoleProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final roleProvider = Provider.of<RoleProvider>(context);

    handleUpdateRole() async {
      setState(() {
        isLoading = true;
      });
      if (userRoleProvider.userId == null && userRoleProvider.roleId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await userRoleProvider.updateUserRole(
        authUserId: userRoleProvider.userId!,
        authRoleId: userRoleProvider.roleId!,
        id: widget.userRole.id!,
      )) {
        await Provider.of<UserRoleProvider>(context, listen: false)
            .fetchUserRole();
        Navigator.pop(context);
        userRoleProvider.setRoleId(null);
        userRoleProvider.setUserId(null);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color5,
          content: Text(
            'Gagal Untuk Update Role, Role sudah ada',
            style: textColor1.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ));
      }
      setState(() {
        isLoading = false;
      });
    }

    edit() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleUpdateRole();
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
            "Edit User Role",
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
                        value: item.id,
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      userRoleProvider
                          .setUserId(int.parse(newValue.toString()));
                      // setState(() {
                      //   valueUser = newValue;
                      //   print(valueUser);
                      // });
                    },
                    value: userRoleProvider.userId,
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
                        value: item.id,
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      userRoleProvider
                          .setRoleId(int.parse(newValue.toString()));
                      // setState(() {
                      //   valueRole = newValue;
                      //   print(valueRole);
                      // });
                    },
                    value: userRoleProvider.roleId,
                  )),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GestureDetector(
                        onTap: edit,
                        child: Container(
                          margin: EdgeInsets.only(top: defaultMargin),
                          height: 50,
                          decoration: BoxDecoration(
                            color: color4,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Edit User Role",
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
