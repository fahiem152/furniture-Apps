import 'package:flutter/material.dart';
import 'package:furniture/screens/Admin/home_admin_screen.dart';
import 'package:furniture/screens/Admin/order_admin_screen.dart';
import 'package:furniture/screens/Admin/prodile_admin_screen.dart';
import 'package:furniture/screens/Admin/supplay_admin_screen.dart';
import 'package:furniture/services/page_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({super.key});

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        child: BottomAppBar(
          // shape: CircularNotchedRectangle(),
          // notchMargin: 12,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
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
                    Icons.receipt_outlined,
                    color: pageProvider.pageIndex == 1 ? color5 : color3,
                  ),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.receipt_long_outlined,
                    color: pageProvider.pageIndex == 2 ? color5 : color3,
                  ),
                  label: 'Supplay',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outline,
                    color: pageProvider.pageIndex == 3 ? color5 : color3,
                  ),
                  label: 'Profile',
                ),
              ]),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.pageIndex) {
        case 0:
          return HomeAdminScreen();
          break;
        case 1:
          return OrderAdminScreen();
          break;
        case 2:
          return SupplayAdminScreen();
          break;
        case 3:
          return ProfileAdminScreen();
          break;
        default:
          return HomeAdminScreen();
      }
    }

    return Scaffold(
      backgroundColor: color1,
      body: SafeArea(child: body()),
      bottomNavigationBar: customBottomNav(),
    );
  }
}
