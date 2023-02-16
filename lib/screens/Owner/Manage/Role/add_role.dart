import 'package:flutter/material.dart';
import 'package:furniture/main.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/screens/Owner/Manage/Role/list_role_manage.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class AddRole extends StatefulWidget {
  const AddRole({super.key});

  @override
  State<AddRole> createState() => _AddRoleState();
}

class _AddRoleState extends State<AddRole> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);

    handleCreateRole() async {
      setState(() {
        isLoading = true;
      });

      if (await roleProvider.createRole(name: _nameController.text)) {
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color5,
          content: Text(
            'Gagal Untuk Create Role',
            style: textColor1.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
            textAlign: TextAlign.center,
          ),
        ));
      }
      print(_nameController.text);
      setState(() {
        isLoading = false;
      });
    }

    add() {
      final form = _formKey.currentState!;
      if (form.validate()) {
        form.save();
        handleCreateRole();
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
            "Add Role",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: color1,
                    border: Border.all(color: color5, width: 2),
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Role Name cannot be empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Role Name",
                      hintStyle: textColor3.copyWith(
                        fontSize: 16,
                        fontWeight: medium,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: color1,
                    ),
                  ),
                ),
                isLoading
                    ? CircularProgressIndicator(
                        color: color4,
                      )
                    : GestureDetector(
                        onTap: add,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: color4,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Add Role",
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
