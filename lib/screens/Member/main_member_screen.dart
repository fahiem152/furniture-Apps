import 'package:flutter/material.dart';
import 'package:furniture/screens/Member/completed_member_screen.dart';
import 'package:furniture/screens/Member/home_member_screen.dart';
import 'package:furniture/screens/Member/order_member_screen.dart';
import 'package:furniture/screens/Member/profile_member_screen.dart';
import 'package:furniture/services/page_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class MainMemberScreen extends StatelessWidget {
  const MainMemberScreen({super.key});

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
                    Icons.shopping_bag_outlined,
                    color: pageProvider.pageIndex == 1 ? color5 : color3,
                  ),
                  label: 'Order',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.verified_outlined,
                    color: pageProvider.pageIndex == 2 ? color5 : color3,
                  ),
                  label: 'Completed',
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
          return HomeMemberScreen();
          break;
        case 1:
          return OrderMemberScreen();
          break;
        case 2:
          return CompletedMemberScreen();
          break;
        case 3:
          return ProfileMemberScreen();
          break;
        default:
          return HomeMemberScreen();
      }
    }

    return Scaffold(
      backgroundColor: color1,
      body: SafeArea(child: body()),
      bottomNavigationBar: customBottomNav(),
    );
  }
}
