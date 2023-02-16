// import 'package:flutter/material.dart';
// import 'package:furniture/models/product_model.dart';
// import 'package:furniture/theme.dart';

// class DetailProduct extends StatefulWidget {
//   final ProductModel product;
//   DetailProduct(this.product);
//   @override
//   State<DetailProduct> createState() => _DetailProductState();
// }

// class _DetailProductState extends State<DetailProduct> {
//   bool isFavorite = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: ListView(
//       children: [
//         Stack(
//           children: [
//             Container(
//               color: color1,
//               width: double.infinity,
//               child: Image.network(
//                 widget.product.urlImage.toString(),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Icon(
//                   Icons.arrow_back_ios,
//                   color: color3,
//                   size: 28,
//                 ),
//               ),
//             )
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.all(
//             30,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Rp. ${widget.product.price.toString()}',
//                     style: textColor3.copyWith(
//                       fontSize: 20,
//                       fontWeight: bold,
//                     ),
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isFavorite = !isFavorite;
//                         });
//                       },
//                       child: (isFavorite)
//                           ? Icon(
//                               Icons.favorite,
//                               color: Colors.red,
//                               size: 24,
//                             )
//                           : Icon(
//                               Icons.favorite_border,
//                               color: Colors.red,
//                               size: 24,
//                             ))
//                 ],
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 '${widget.product.name.toString()}',
//                 style: textColor3.copyWith(
//                   fontSize: 20,
//                   fontWeight: medium,
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 'Detail Product',
//                 style: textColor3.copyWith(
//                   fontSize: 20,
//                   fontWeight: bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Container(
//                 width: 150,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Category',
//                       style: textColor3.copyWith(
//                         fontSize: 16,
//                         fontWeight: light,
//                       ),
//                     ),
//                     Text(
//                       '${widget.product.category!.name.toString()}',
//                       style: textColor3.copyWith(
//                         fontSize: 16,
//                         fontWeight: reguler,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: 150,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Brand',
//                       style: textColor3.copyWith(
//                         fontSize: 16,
//                         fontWeight: light,
//                       ),
//                     ),
//                     Text(
//                       '${widget.product.brand!.name.toString()}',
//                       style: textColor3.copyWith(
//                         fontSize: 16,
//                         fontWeight: reguler,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 'Description Product',
//                 style: textColor3.copyWith(
//                   fontSize: 20,
//                   fontWeight: bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 '${widget.product.description.toString()}',
//                 style: textColor3.copyWith(
//                   fontSize: 16,
//                   fontWeight: reguler,
//                 ),
//                 textAlign: TextAlign.justify,
//               ),
//             ],
//           ),
//         )
//       ],
//     ));
//   }
// }
