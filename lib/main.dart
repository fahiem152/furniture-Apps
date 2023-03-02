import 'package:flutter/material.dart';

import 'package:furniture/providers/auth_provider.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/order_product_provider.dart';
import 'package:furniture/providers/product_provider.dart';
import 'package:furniture/providers/role_provider.dart';
import 'package:furniture/providers/search_provider.dart';
import 'package:furniture/providers/supplay_product_provider.dart';
import 'package:furniture/providers/supplier_provider.dart';
import 'package:furniture/providers/user_providers.dart';
import 'package:furniture/providers/user_role_provider.dart';
import 'package:furniture/screens/Admin/OrderProduct/add_order_product.dart';
import 'package:furniture/screens/Admin/SupplayProduct/add_supplay_product.dart';
import 'package:furniture/screens/Admin/detail_product_admin_screen.dart';
import 'package:furniture/screens/Admin/home_admin_screen.dart';
import 'package:furniture/screens/Admin/main_admin_screen.dart';
import 'package:furniture/screens/Kurir/home_kurir_screen.dart';
import 'package:furniture/screens/Owner/Manage/Brand/add_brand.dart';
import 'package:furniture/screens/Owner/Manage/Category/add_category.dart';
import 'package:furniture/screens/Owner/Manage/Product/add_product.dart';
import 'package:furniture/screens/Owner/Manage/Role/add_role.dart';
import 'package:furniture/screens/Owner/Manage/Supplier/add_supplier.dart';
import 'package:furniture/screens/Owner/Manage/User/add_user.dart';
import 'package:furniture/screens/Owner/Manage/UserRole/add_user_role.dart';

import 'package:furniture/screens/Owner/home_owner_screen.dart';
import 'package:furniture/screens/Owner/main_owner_screen.dart';
import 'package:furniture/screens/login_screen.dart';
import 'package:furniture/screens/splash_screen.dart';
import 'package:furniture/services/page_provider.dart';
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
          create: (context) => RoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRoleProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BrandProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SupplierProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SupplayProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProductProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => SearchProvider(),
        // ),

        // // ChangeNotifierProvider(
        // //   create: (context) => UserProvider(),
        // // ),
        // ChangeNotifierProvider(
        //   create: (context) => TabProvider(),
        // ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/admin': (context) => MainAdminScreen(),
          '/kurir': (context) => HomeKurirScreen(),
          '/owner': (context) => MainOwnerScreen(),
          '/add-role': (context) => AddRole(),
          '/add-user': (context) => AddUser(),
          '/add-user-role': (context) => AddUserRole(),
          '/add-brand': (context) => AddBrand(),
          '/add-category': (context) => AddCategory(),
          '/add-product': (context) => AddProduct(),
          '/add-supplier': (context) => AddSupplier(),
          '/add-supplay-product': (context) => AddSupplayProduct(),
          '/add-order-product': (context) => AddOrderProduct(),

          // '/addproduct': (context) => AddProduct(),
        },
      ),
    );
  }
}
