import 'package:flutter/material.dart';
import 'package:furniture/models/supplay_product_model.dart';
import 'package:furniture/services/supplay_product_service.dart';

class SupplayProductProvider with ChangeNotifier {
  SupplayProductService _supplayProductService = SupplayProductService();
  List<SupplayProductModel> _supplayProducts = [];
  SupplayProductModel _supplayProduct =
      SupplayProductModel(price: 0, quantity: 0, productId: 0, supplierId: 0);

  List<SupplayProductModel> get supplayProducts => _supplayProducts;

  Future<void> fetchSupplayProduct() async {
    try {
      _supplayProducts = await _supplayProductService.fetchSupplayProduct();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createSupplayProduct({
    required int productId,
    required int supplierId,
    required int price,
    required int quantity,
  }) async {
    try {
      SupplayProductModel supplayProduct =
          await _supplayProductService.createSupplayProduct(
        productId: productId,
        supplierId: supplierId,
        price: price,
        quantity: quantity,
      );
      _supplayProduct = supplayProduct;
      _supplayProducts.add(_supplayProduct);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateSupplayProduct({
    required int productId,
    required int supplierId,
    required int price,
    required int quantity,
    required int id,
  }) async {
    try {
      SupplayProductModel supplayProduct =
          await _supplayProductService.updateSupplayProduct(
        productId: productId,
        supplierId: supplierId,
        price: price,
        quantity: quantity,
        id: id,
      );
      int index = _supplayProducts.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _supplayProducts[index] = supplayProduct;
      }
      _supplayProduct = supplayProduct;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteSupplayProduct({required int id}) async {
    try {
      await _supplayProductService.deleteSupplayProduct(id: id);
      _supplayProducts.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
