import 'package:flutter/material.dart';
import 'package:furniture/screens/Kurir/delivered_kurir_sreen.dart';
import 'package:furniture/screens/Kurir/delivery_kurir_screen.dart';
import 'package:furniture/screens/Kurir/home_kurir_screen.dart';
import 'package:furniture/services/page_provider.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class MainKurirScreen extends StatelessWidget {
  const MainKurirScreen({super.key});

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
                    Icons.delivery_dining_outlined,
                    color: pageProvider.pageIndex == 1 ? color5 : color3,
                  ),
                  label: 'Delivery',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.fact_check_outlined,
                    color: pageProvider.pageIndex == 2 ? color5 : color3,
                  ),
                  label: 'Delivered',
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
          return HomeKurirScreen();
          break;
        case 1:
          return DeliverKurirScreen();
          break;
        case 2:
          return DeliveredKurirScreen();
          break;
        case 3:
          return Container(
            child: Center(
              child: Text('Delivery'),
            ),
          );
          break;
        default:
          return HomeKurirScreen();
      }
    }

    return Scaffold(
      backgroundColor: color1,
      bottomNavigationBar: customBottomNav(),
      body: SafeArea(child: body()),
    );
  }
}
