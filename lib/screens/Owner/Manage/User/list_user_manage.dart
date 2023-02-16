import 'package:flutter/material.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/screens/Owner/Manage/User/edit_user.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListUserManage extends StatefulWidget {
  const ListUserManage({super.key});

  @override
  State<ListUserManage> createState() => _ListUserManageState();
}

class _ListUserManageState extends State<ListUserManage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProvider>(context).users;

    return userList.length == 0
        ? Center(
            child: CircularProgressIndicator(
              color: color5,
            ),
          )
        : Stack(
            children: [
              ListView.builder(
                  itemCount: userList.length,
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
                                      userList[index].id.toString(),
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
                                      userList[index].name,
                                      style: textColor3.copyWith(
                                          fontSize: 16, fontWeight: semiBold),
                                    ),
                                    Text(
                                      userList[index].email,
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditUser(
                                                user: userList[index])));
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
                                              userList[index].name +
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
                                            await Provider.of<UserProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteUser(
                                                    id: int.parse(
                                                        userList[index]
                                                            .id
                                                            .toString()));
                                            Navigator.pop(context);
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
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/add-user');
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
