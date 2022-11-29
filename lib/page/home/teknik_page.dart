// import 'package:flutter/material.dart';

// import 'package:furniture/providers/user_providers.dart';
// import 'package:furniture/theme.dart';
// import 'package:furniture/widgets/card_product.dart';
// import 'package:provider/provider.dart';

// class TeknikPage extends StatefulWidget {
//   const TeknikPage({super.key});

//   @override
//   State<TeknikPage> createState() => _TeknikPageState();
// }

// class _TeknikPageState extends State<TeknikPage> {
//   TextEditingController textEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     print('Jumlah User TeknikPages: ${userProvider.users.length}');

//     return Scaffold(
//       body: SafeArea(
//         child: LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//           return Container(
//             color: color2,
//             child: Stack(children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.20,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: defaultMargin,
//                   vertical: 20,
//                 ),
//                 color: color4,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Mahsiswa Unaki",
//                           style: textColor1.copyWith(
//                             fontSize: 28,
//                             fontWeight: bold,
//                             letterSpacing: 1,
//                           ),
//                         ),
//                         Icon(
//                           Icons.notifications_active,
//                           color: color1,
//                         )
//                       ],
//                     ),
//                     Container(
//                       height: 50,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             Container(
//                               margin: EdgeInsets.only(
//                                 right: 12,
//                               ),
//                               width: 75,
//                               height: 25,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(
//                                   12,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Teknik',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     letterSpacing: 1,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushNamed(context, '/bahasa');
//                               },
//                               child: Container(
//                                 width: 75,
//                                 height: 25,
//                                 margin: EdgeInsets.only(
//                                   right: 12,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color: Colors.white,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(
//                                     12,
//                                   ),
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'Bahasa',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w400,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 75,
//                               height: 25,
//                               margin: EdgeInsets.only(
//                                 right: 12,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(
//                                   12,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Ekonomi',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w400,
//                                     letterSpacing: 1,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               width: 75,
//                               height: 25,
//                               margin: EdgeInsets.only(
//                                 right: 12,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.white,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(
//                                   12,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   'Psikologi',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.w400,
//                                     letterSpacing: 1,
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.75,
//                 margin: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.17,
//                   left: MediaQuery.of(context).size.height * 0.07,
//                 ),
//                 padding: EdgeInsets.all(16),
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: color1,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                   child: TextFormField(
//                     style: textColor3.copyWith(
//                       fontSize: 20,
//                       fontWeight: medium,
//                     ),
//                     controller: textEditingController,
//                     decoration: InputDecoration.collapsed(
//                       hintText: 'Search Name in Here',
//                       hintStyle: textColor3.copyWith(
//                         fontSize: 16,
//                         fontWeight: reguler,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.only(
//                   top: MediaQuery.of(context).size.height * 0.25,
//                 ),
//                 child: GridViewCount(),
//               ),
//             ]),
//           );
//         }),
//       ),
//     );
//   }
// }

// class GridViewCount extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     return GridView.count(
//       crossAxisCount: 2,
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       childAspectRatio: 0.75,
//       children: userProvider.users
//           .map((user) => CardProduct(
//                 user: user,
//               ))
//           .toList(),
//     );
//   }
// }
