import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  // late ProductModel _product;
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  set products(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductModel> products = await ProductService().getProducts();
      _products = products;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addProduct({
    String? name,
    String? description,
    int? price,
    String? urlImage,
    int? categoryId,
    int? brandId,
  }) async {
    try {
      ProductModel product = await ProductService().addProduct(
        name!,
        description!,
        price!,
        urlImage!,
        categoryId!,
        brandId!,
      );
      // _product = product;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
