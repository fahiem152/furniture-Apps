// import 'package:flutter/material.dart';
// import 'package:furniture/services/order_product_service.dart';

// mixin ScrollHandlerMixin on State<StatefulWidget> {
//   final ScrollController _scrollController = ScrollController();
//   int _currentPage = 0;

//   bool handleScrollNotification(ScrollNotification scrollNotification) {
//     if (scrollNotification is ScrollUpdateNotification) {
//       if (_scrollController.position.maxScrollExtent > _scrollController.offset &&
//           _scrollController.position.maxScrollExtent - _scrollController.offset <=
//               50) {
//         setState(() {
//           _currentPage += 1;
//           OrderProductService.fetchOrderProduct(_currentPage)
//         });
//       }
//     }
//     return true;
//   }
// }