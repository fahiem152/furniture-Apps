import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  // late ProductModel _product;
  List<ProductModel> _products = [];

  String _searchText = '';

  List<ProductModel> get products => _products;
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    return _products
        .where((product) =>
            product.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  Future<void> getProducts() async {
    try {
      final productService = ProductService();
      _products = await productService.getProducts();
      notifyListeners();
    } catch (e) {
      print('provider Product errorr: ' + e.toString());
    }
  }

  // Future<bool> addProduct({
  //   String? name,
  //   String? description,
  //   int? price,
  //   String? urlImage,
  //   int? categoryId,
  //   int? brandId,
  // }) async {
  //   try {
  //     ProductModel product = await ProductService().addProduct(
  //       name!,
  //       description!,
  //       price!,
  //       urlImage!,
  //       categoryId!,
  //       brandId!,
  //     );
  //     // _product = product;

  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }
}
