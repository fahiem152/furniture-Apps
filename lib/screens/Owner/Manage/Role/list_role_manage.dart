import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/screens/Owner/Manage/Role/edit_role.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListRoleManage extends StatefulWidget {
  const ListRoleManage({super.key});

  @override
  State<ListRoleManage> createState() => _ListRoleManageState();
}

class _ListRoleManageState extends State<ListRoleManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<RoleProvider>(context, listen: false).fetchRole();
  }

  @override
  Widget build(BuildContext context) {
    final roleList = Provider.of<RoleProvider>(context).roles;

    return roleList.length == 0
        ? Center(
            child: CircularProgressIndicator(
              color: color5,
            ),
          )
        : Stack(
            children: [
              ListView.builder(
                itemCount: roleList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(16, 8, 16, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: color5,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  roleList[index].id.toString(),
                                  style: textColor1.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              roleList[index].name,
                              style: textColor3.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditRole(
                                              role: roleList[index],
                                            )));
                              },
                              icon: Icon(
                                Icons.edit,
                                color: color5,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Alert(
                                  context: context,
                                  type: AlertType.warning,
                                  title: "Hapus Role",
                                  desc:
                                      'Apakah Anda Yakin Ingin Menghapus Role "' +
                                          roleList[index].name +
                                          '" ?',
                                  buttons: [
                                    DialogButton(
                                      child: Text(
                                        "Tidak",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      color: color4,
                                    ),
                                    DialogButton(
                                      child: Text(
                                        "Ya",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        await Provider.of<RoleProvider>(context,
                                                listen: false)
                                            .deleteRole(
                                                id: int.parse(roleList[index]
                                                    .id
                                                    .toString()));
                                        Navigator.pop(context);
                                      },
                                      color: color5,
                                    )
                                  ],
                                ).show();
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return AlertDialog(
                                //       title: Text('Hapus Role'),
                                //       content: Text(
                                //           'Apakah Anda Yakin Ingin Menghapus Role "' +
                                //               roleList[index].name +
                                //               '" ?'),
                                //       actions: [
                                //         TextButton(
                                //           onPressed: () {
                                //             Navigator.pop(context);
                                //           },
                                //           child: Text('Tidak'),
                                //         ),
                                //         TextButton(
                                //           onPressed: () async {
                                //             await Provider.of<RoleProvider>(
                                //                     context,
                                //                     listen: false)
                                //                 .deleteRole(
                                //                     id: int.parse(roleList[index]
                                //                         .id
                                //                         .toString()));
                                //             Navigator.pop(context);
                                //           },
                                //           child: Text('Ya'),
                                //         ),
                                //       ],
                                //     );
                                //   },
                                // );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: color4,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-role');
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ),
                      color: color5,
                    ),
                    child: Icon(
                      Icons.add,
                      color: color1,
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
