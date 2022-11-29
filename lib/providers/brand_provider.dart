import 'package:flutter/material.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/branch_services.dart';
import 'package:furniture/services/category_services.dart';

class BrandProvider with ChangeNotifier {
  List<BrandModel> _brands = [];

  List<BrandModel> get brands => _brands;

  set brands(List<BrandModel> brands) {
    _brands = brands;
    notifyListeners();
  }

  Future<void> getBrands() async {
    try {
      List<BrandModel> brands = await BrandService().getBrands();
      _brands = brands;
    } catch (e) {
      print(e);
    }
  }
}
