// import 'package:flutter/material.dart';
// import 'package:furniture/models/order_product_model.dart';
// import 'package:furniture/providers/order_product_provider.dart';
// import 'package:furniture/providers/product_provider.dart';
// import 'package:furniture/screens/Admin/OrderProduct/detail_order_admin_screen.dart';
// import 'package:furniture/screens/Admin/OrderProduct/edit_order_product.dart';
// import 'package:furniture/theme.dart';
// import 'package:provider/provider.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// class OrderAdminScreen extends StatefulWidget {
//   const OrderAdminScreen({super.key});

//   @override
//   State<OrderAdminScreen> createState() => _OrderAdminScreenState();
// }

// class _OrderAdminScreenState extends State<OrderAdminScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Provider.of<OrderProductProvider>(context, listen: false)
//         .fetchOrderProduct();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderProductProvider = Provider.of<OrderProductProvider>(context);
//     return Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 20,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Order Product',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Text(
//                     'All',
//                     style: TextStyle(
//                       color: Color(0xff4169E1),
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: orderProductProvider.orderProducts.length,
//                   itemBuilder: (context, index) {
//                     return CardOrderOwner(
//                       isDetail: true,
//                       isEdit: true,
//                       isDelete: true,
//                       orderProduct: orderProductProvider.orderProducts[index],
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, '/add-order-product');
//             },
//             child: Container(
//               margin: EdgeInsets.only(
//                 right: 16,
//                 bottom: 16,
//               ),
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   25,
//                 ),
//                 color: color5,
//               ),
//               child: Icon(
//                 Icons.add,
//                 color: color1,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class CardOrderOwner extends StatelessWidget {
// //   OrderProductModel orderProduct;
// //   bool isDelete = true;
// //   bool isEdit = true;
// //   bool isDetail = true;

// //   CardOrderOwner({
// //     super.key,
// //     required this.orderProduct,
// //     required this.isDelete,
// //     required this.isEdit,
// //     required this.isDetail,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: defaultMargin),
// //       decoration: BoxDecoration(
// //         boxShadow: [
// //           BoxShadow(
// //             color: color5.withOpacity(0.1),
// //             spreadRadius: 2,
// //             blurRadius: 3,
// //             offset: Offset(0, 3), // changes position of shadow
// //           ),
// //         ],
// //         color: color2.withOpacity(0.3),
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       width: double.infinity,
// //       height: 170,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   width: 100,
// //                   height: 100,
// //                   decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(10),
// //                     image: DecorationImage(
// //                       image: NetworkImage(
// //                         orderProduct.product != null
// //                             // orderProduct.product!.urlImage != null &&
// //                             //         orderProduct.product!.urlImage != ''
// //                             ? orderProduct.product!.urlImage
// //                             : 'https://p-id.ipricegroup.com/uploaded_05c89a7d0eb7e5535bbd31ec7db91d99.jpg',
// //                       ),
// //                       fit: BoxFit.cover,
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(
// //                   width: 20,
// //                 ),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         orderProduct.customerName,
// //                         style: textColor3.copyWith(
// //                           fontSize: 16,
// //                           fontWeight: semiBold,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(
// //                         height: 4,
// //                       ),
// //                       Text(
// //                         orderProduct.customerAddres,
// //                         style: textColor3.copyWith(
// //                           fontSize: 16,
// //                           fontWeight: reguler,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(
// //                         height: 4,
// //                       ),
// //                       Text(
// //                         orderProduct.product != null
// //                             ? orderProduct.product!.name
// //                             : 'Product Name',
// //                         style: textColor3.copyWith(
// //                           fontSize: 16,
// //                           fontWeight: reguler,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       SizedBox(
// //                         height: 4,
// //                       ),
// //                       Text(
// //                         '${orderProduct.quantity != null ? orderProduct.quantity : 1.toString()} Produk',
// //                         style: textColor3.copyWith(
// //                           fontSize: 16,
// //                           fontWeight: reguler,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               // GestureDetector(
// //               //   onTap: () {
// //               //     Navigator.push(
// //               //         context,
// //               //         MaterialPageRoute(
// //               //             builder: (context) => DetailOrderAdminScreen(
// //               //                   orderProduct: orderProduct,
// //               //                 )));
// //               //   },
// //               //   child: Container(
// //               //     height: 40,
// //               //     width: MediaQuery.of(context).size.width * 0.25,
// //               //     decoration: BoxDecoration(
// //               //       color: color4,
// //               //       borderRadius: BorderRadius.circular(
// //               //         10,
// //               //       ),
// //               //     ),
// //               //     child: Center(
// //               //         child: Text(
// //               //       'Detail Order',
// //               //       style: textColor3.copyWith(
// //               //         fontSize: 16,
// //               //         fontWeight: reguler,
// //               //       ),
// //               //     )),
// //               //   ),
// //               // ),

// //               isEdit
// //                   ? ElevatedButton(
// //                       style: ButtonStyle(
// //                         backgroundColor: MaterialStateProperty.all(color5),
// //                         shape: MaterialStateProperty.all(
// //                           RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(
// //                               12,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         final productProvider = Provider.of<ProductProvider>(
// //                           context,
// //                           listen: false,
// //                         );
// //                         final orderProvider = Provider.of<OrderProductProvider>(
// //                           context,
// //                           listen: false,
// //                         );
// //                         productProvider.setValueProduct(
// //                           orderProduct.product!.id,
// //                         );
// //                         orderProvider.setDeliveryType(
// //                           orderProduct.deliveryType,
// //                         );
// //                         orderProvider.setDeliveryStatus(
// //                           orderProduct.deliveryStatus,
// //                         );

// //                         Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                             builder: (context) => EditOrderProduct(
// //                               orderProduct: orderProduct,
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                       child: Container(
// //                         height: 40,
// //                         width: MediaQuery.of(context).size.width * 0.2,
// //                         child: Center(
// //                           child: Text(
// //                             'Edit',
// //                             style: textColor1.copyWith(
// //                               fontSize: 16,
// //                               fontWeight: reguler,
// //                               letterSpacing: 1,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     )
// //                   : Container(),
// //               isDelete
// //                   ? ElevatedButton(
// //                       style: ButtonStyle(
// //                         backgroundColor: MaterialStateProperty.resolveWith(
// //                             (states) => color7),
// //                         shape: MaterialStateProperty.all(
// //                           RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(
// //                               12,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Alert(
// //                           context: context,
// //                           type: AlertType.warning,
// //                           title: "Hapus Order Product",
// //                           desc:
// //                               'Apakah Anda Yakin Ingin Menghapus Order Product "' +
// //                                   orderProduct.product!.name +
// //                                   '" ' +
// //                                   "Atas Nama " +
// //                                   '"' +
// //                                   orderProduct.customerName +
// //                                   '" ?',
// //                           buttons: [
// //                             DialogButton(
// //                               child: Text(
// //                                 "Tidak",
// //                                 style: TextStyle(
// //                                     color: Colors.white, fontSize: 20),
// //                               ),
// //                               onPressed: () => Navigator.pop(context),
// //                               color: color4,
// //                             ),
// //                             DialogButton(
// //                               child: Text(
// //                                 "Ya",
// //                                 style: TextStyle(
// //                                     color: Colors.white, fontSize: 20),
// //                               ),
// //                               onPressed: () async {
// //                                 await Provider.of<OrderProductProvider>(context,
// //                                         listen: false)
// //                                     .deleteOrderProduct(
// //                                         id: int.parse(
// //                                             orderProduct.id.toString()));
// //                                 Navigator.pop(context);
// //                               },
// //                               color: color5,
// //                             )
// //                           ],
// //                         ).show();
// //                       },
// //                       child: Container(
// //                         height: 40,
// //                         width: MediaQuery.of(context).size.width * 0.2,
// //                         child: Center(
// //                           child: Text(
// //                             'Delete',
// //                             style: textColor1.copyWith(
// //                               fontSize: 16,
// //                               fontWeight: reguler,
// //                               letterSpacing: 1,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     )
// //                   : Container(),
// //               isDetail
// //                   ? ElevatedButton(
// //                       style: ButtonStyle(
// //                         backgroundColor: MaterialStateProperty.all(color4),
// //                         shape: MaterialStateProperty.all(
// //                           RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(
// //                               12,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                                 builder: (context) => DetailOrderAdminScreen(
// //                                       orderProduct: orderProduct,
// //                                     )));
// //                       },
// //                       child: Container(
// //                         height: 40,
// //                         width: MediaQuery.of(context).size.width * 0.2,
// //                         child: Center(
// //                           child: Text(
// //                             'Detail',
// //                             style: textColor1.copyWith(
// //                               fontSize: 16,
// //                               fontWeight: reguler,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     )
// //                   : Container(),
// //             ],
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }
