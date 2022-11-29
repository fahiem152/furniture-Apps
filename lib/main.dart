import 'package:flutter/material.dart';

import 'package:furniture/page/home/main_page.dart';

import 'package:furniture/page/home/teknik_page.dart';
import 'package:furniture/page/splash.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/tab_provider.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BrandProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => UserProvider(),
        // ),
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplahPage(),
          '/main': (context) => MainPage(),
        },
      ),
    );
  }
}
