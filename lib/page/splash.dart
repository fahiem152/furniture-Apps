import 'package:flutter/material.dart';
import 'package:furniture/providers/brand_provider.dart';
import 'package:furniture/providers/category_provider.dart';
import 'package:furniture/providers/product_provider.dart';

import 'package:furniture/theme.dart';
import 'package:provider/provider.dart';

class SplahPage extends StatefulWidget {
  const SplahPage({super.key});

  @override
  State<SplahPage> createState() => _SplahPageState();
}

class _SplahPageState extends State<SplahPage> {
  @override
  void initState() {
    getInt();
    super.initState();
  }

//  @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getProvince(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
//   }
  getInt() async {
    await Provider.of<BrandProvider>(context, listen: false).getBrands();
    await Provider.of<CategoryProvider>(context, listen: false).geCategorys();
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    Navigator.pushNamed(context, '/main');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Center(
          child: FlutterLogo(
        size: 300,
        textColor: Colors.blue,
        style: FlutterLogoStyle.stacked,
      )),
    );
  }
}
