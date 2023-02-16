import 'package:flutter/material.dart';
import 'package:furniture/models/role_model.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class EditRole extends StatefulWidget {
  RoleModel role;
  EditRole({super.key, required this.role});

  @override
  State<EditRole> createState() => _EditRoleState();
}

class _EditRoleState extends State<EditRole> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.role.name;
    // final roleProvider = Provider.of<RoleProvider>(context, listen: false).fetchRole();
    //    final roleList = Provider.of<RoleProvider>(context).roles;
    // _nameController.text = roleList[].name;
  }

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);

    handleUpdateRole() async {
      setState(() {
        isLoading = true;
      });

      if (await roleProvider.updateRole(
        name: _nameController.text,
        id: widget.role.id!,
      )) {
        Navigator.pop(context);
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
      print(_nameController.text);
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
            "Edit Role",
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
                // Text(
                //   widget.role.name,
                //   style: textColor3.copyWith(
                //     fontSize: 16,
                //     fontWeight: medium,
                //   ),
                // ),
                isLoading
                    ? CircularProgressIndicator(
                        color: color4,
                      )
                    : GestureDetector(
                        onTap: edit,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: color4,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Update Role",
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
