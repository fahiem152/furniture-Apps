import 'package:flutter/material.dart';
import 'package:furniture/screens/Admin/home_admin_screen.dart';
import 'package:furniture/screens/Owner/home_owner_screen.dart';
import 'package:furniture/screens/Owner/manajemen_Owner_screen.dart';
import 'package:furniture/services/page_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class MainOwnerScreen extends StatelessWidget {
  const MainOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget custtomButtomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          // notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              selectedFontSize: 16,
              backgroundColor: color1,
              type: BottomNavigationBarType.fixed,
              currentIndex: pageProvider.pageIndex,
              onTap: (value) {
                pageProvider.pageIndex = value;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    color: pageProvider.pageIndex == 0 ? color5 : color3,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.manage_accounts_outlined,
                    color: pageProvider.pageIndex == 1 ? color5 : color3,
                  ),
                  label: 'Manage Apps',
                ),
              ]),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.pageIndex) {
        case 0:
          return HomeOwnerScreen();
        case 1:
          return ManajemenOwnerScreen();
        default:
          return Container(
            color: color1,
          );
      }
    }

    return Scaffold(
      backgroundColor: color1,
      body: body(),
      bottomNavigationBar: custtomButtomNav(),
    );
  }
}
