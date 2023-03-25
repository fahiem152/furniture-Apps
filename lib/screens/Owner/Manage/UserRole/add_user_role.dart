import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/providers/user_role_provider.dart';
import 'package:furniture/screens/Owner/manajemen_owner_screen.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddUserRole extends StatefulWidget {
  const AddUserRole({super.key});

  @override
  State<AddUserRole> createState() => _AddUserRoleState();
}

class _AddUserRoleState extends State<AddUserRole> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  bool isLoading = false;
  // var valueRole;
  // var valueUser;
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
      // final addUserRole = await userRoleProvider.createUserRole(
      //   authUserId: userRoleProvider.userId!,
      //   authRoleId: userRoleProvider.roleId!,
      // );
      // if (addUserRole) {
      //   Navigator.pop(context);

      // }

      if (userRoleProvider.userId == null && userRoleProvider.roleId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Silakan pilih opsi terlebih dahulu'),
          ),
        );
      } else if (await userRoleProvider.createUserRole(
        // user_id: valueUser, role_id: valueRole
        authUserId: userRoleProvider.userId!,
        authRoleId: userRoleProvider.roleId!,
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
            'Gagal Untuk Create User Role',
            style: textColor1.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ));
      }
      print('Role id: ${userRoleProvider.userId.toString()}' +
          " User id: ${userRoleProvider.roleId.toString()}");
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: color1,
                    border: Border.all(color: color5, width: 2),
                  ),
                  child: TypeAheadFormField(
                    noItemsFoundBuilder: (context) => SizedBox(
                      height: 50,
                      child: Center(
                        child: Text('No User Found'),
                      ),
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                      elevation: 4.0,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    debounceDuration: const Duration(milliseconds: 400),
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _userController,
                      decoration: InputDecoration(
                        labelText: "Nama User",
                        hintText: "Cari User",
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return await userProvider.users
                          .where((user) => user.name
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .map((user) => {'id': user.id, 'name': user.name})
                          .toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion['name'].toString()),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      userRoleProvider
                          .setUserId(int.parse(suggestion['id'].toString()));

                      _userController.text = suggestion['name'].toString();
                    },
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: defaultMargin),
                //   padding: EdgeInsets.symmetric(horizontal: 12),
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     border: Border.all(color: color5, width: 1),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: DropdownButtonHideUnderline(
                //       child: DropdownButton(
                //     hint: Text(
                //       'Select User',
                //     ),
                //     items: userProvider.users.map((item) {
                //       return DropdownMenuItem(
                //         child: Text(item.name),
                //         value: item.id,
                //       );
                //     }).toList(),
                //     onChanged: (newValue) {
                //       userRoleProvider.setUserId(
                //         int.parse(
                //           newValue.toString(),
                //         ),
                //       );
                //       // setState(() {
                //       //   valueUser = newValue;
                //       //   print(valueUser);
                //       // });
                //     },
                //     value: userRoleProvider.userId,
                //   )),
                // ),
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
                      userRoleProvider.setRoleId(
                        int.parse(
                          newValue.toString(),
                        ),
                      );
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
