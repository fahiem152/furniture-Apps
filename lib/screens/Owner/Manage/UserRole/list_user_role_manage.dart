import 'package:flutter/material.dart';
import 'package:furniture/providers/user_role_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListUserRoleManage extends StatefulWidget {
  const ListUserRoleManage({super.key});

  @override
  State<ListUserRoleManage> createState() => _ListUserRoleManageState();
}

class _ListUserRoleManageState extends State<ListUserRoleManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserRoleProvider>(context, listen: false).fetchUserRole();
  }

  @override
  Widget build(BuildContext context) {
    final userRoleList = Provider.of<UserRoleProvider>(context).userRoles;
    return userRoleList.length == 0
        ? Center(
            child: CircularProgressIndicator(
              color: color5,
            ),
          )
        : Stack(
            children: [
              ListView.builder(
                  itemCount: userRoleList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.fromLTRB(16, 8, 16, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: color5,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      userRoleList[index].id.toString(),
                                      style: textColor1.copyWith(
                                        fontSize: 16,
                                        fontWeight: semiBold,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userRoleList[index].user!.name,
                                      style: textColor3.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                    Text(
                                      userRoleList[index].role!.name,
                                      style: textColor3.copyWith(
                                        fontSize: 12,
                                        fontWeight: reguler,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => EditUser(
                                    //             user: userList[index])));
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
                                              // userList[index].name +
                                              '" ?',
                                      buttons: [
                                        DialogButton(
                                          child: Text(
                                            "Tidak",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          color: color4,
                                        ),
                                        DialogButton(
                                          child: Text(
                                            "Ya",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () async {
                                            // await Provider.of<UserProvider>(
                                            //         context,
                                            //         listen: false)
                                            //     .deleteUser(
                                            //         id: int.parse(
                                            //             userList[index]
                                            //                 .id
                                            //                 .toString()));
                                            // Navigator.pop(context);
                                          },
                                          color: color5,
                                        )
                                      ],
                                    ).show();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: color4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ));
                  }),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-user-role');
                    },
                    child: Icon(Icons.add),
                    backgroundColor: color5,
                  ),
                ),
              )
            ],
          );
  }
}
