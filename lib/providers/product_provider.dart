import 'package:flutter/material.dart';
import 'package:furniture/models/product_model.dart';
import 'package:furniture/services/product_services.dart';

class ProductProvider with ChangeNotifier {
  ProductService _productService = ProductService();
  List<ProductModel> _products = [];
  ProductModel _product = ProductModel(
    name: '',
    description: '',
    price: 0,
    urlImage: '',
    brandId: 0,
    categoryId: 0,
  );
  int? _valueProduct;

  String _searchText = '';

  List<ProductModel> get products => _products;
  int? get valueProduct => _valueProduct;
  String get searchText => _searchText;
  ProductModel? _selectProduct;
  ProductModel? get selectProduct => _selectProduct;

  void setValueProduct(int? value) {
    _valueProduct = value;
    notifyListeners();
  }

  // void setSelectProduct(ProductModel? product) {
  //   _selectProduct = product!;
  //   notifyListeners();
  // }

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

  Future searchProduct(String params) async {
    List<ProductModel> result = await _products
        .where((element) =>
            element.name.toLowerCase().contains(params.toLowerCase()))
        .toList();
    return result;
  }

  Future<void> fetchProduct() async {
    try {
      _products = await _productService.fetchProduct();
      notifyListeners();
    } catch (e) {
      print('provider Product errorr: ' + e.toString());
    }
  }

  Future<bool> createProduct({
    required String name,
    required String description,
    required int brandId,
    required int categoryId,
    required int price,
    required String urlImage,
  }) async {
    try {
      ProductModel product = await _productService.createProduct(
        name: name,
        description: description,
        brandId: brandId,
        categoryId: categoryId,
        price: price,
        urlImage: urlImage,
      );
      _product = product;
      _products.add(product);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateProduct({
    required String name,
    required String description,
    required int brandId,
    required int categoryId,
    required int price,
    required String urlImage,
    required int id,
  }) async {
    try {
      ProductModel product = await _productService.updateProduct(
        name: name,
        description: description,
        brandId: brandId,
        categoryId: categoryId,
        price: price,
        urlImage: urlImage,
        id: id,
      );
      int index = _products.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _products[index] = product;
      }
      _product = product;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteProduct({required int id}) async {
    try {
      await _productService.deleteProduct(id: id);
      _products.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
