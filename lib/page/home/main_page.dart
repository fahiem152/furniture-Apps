// import 'package:flutter/material.dart';
// import 'package:furniture/page/home/brand_page.dart';
// import 'package:furniture/page/home/category_page.dart';
// import 'package:furniture/page/home/pegawai_page.dart';
// import 'package:furniture/page/home/product_page.dart';
// import 'package:furniture/theme.dart';

// class MainPage extends StatefulWidget {
//   MainPage({Key? key}) : super(key: key);

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   TabBar myTabBar = TabBar(
//     labelColor: color1,
//     indicator: BoxDecoration(
//       borderRadius: BorderRadius.circular(
//         20,
//       ),
//       border: Border.all(
//         width: 2,
//         color: color1,
//       ),
//     ),
//     tabs: [
//       Tab(
//         text: 'Product',
//       ),
//       Tab(
//         text: 'Category',
//       ),
//       Tab(
//         text: 'Brand',
//       ),
//       Tab(
//         text: 'Pegawai',
//       ),
//     ],
//   );
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             backgroundColor: color4,
//             title: Text(
//               "Anugrah Furniture",
//               style: textColor1.copyWith(
//                 fontSize: 28,
//                 fontWeight: bold,
//                 letterSpacing: 1,
//               ),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 24),
//                 child: Icon(
//                   Icons.notifications_active,
//                   color: color1,
//                 ),
//               )
//             ],
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(75),
//               child: Container(
//                 margin: EdgeInsets.only(
//                   left: 4,
//                   right: 4,
//                   bottom: 24,
//                 ),
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: color4,
//                 ),
//                 child: myTabBar,
//               ),
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               ProductPage(),
//               CategoryPage(),
//               BrandPage(),
//               PegawaiPage(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
