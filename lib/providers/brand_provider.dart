import 'package:flutter/material.dart';
import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/brand_services.dart';
import 'package:furniture/services/category_services.dart';

class BrandProvider with ChangeNotifier {
  BrandService _brandService = BrandService();
  List<BrandModel> _brands = [];
  BrandModel _brand = BrandModel(name: '', brandImg: '');

  List<BrandModel> get brands => _brands;

  // set brands(List<BrandModel> brands) {
  //   _brands = brands;
  //   notifyListeners();
  // }

  Future<void> fetchBrand() async {
    try {
      _brands = await _brandService.fetchBrand();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createBrand({
    required String name,
    required String imgUrl,
  }) async {
    try {
      BrandModel brand = await _brandService.createBrand(
        name: name,
        imgUrl: imgUrl,
      );
      _brand = brand;
      _brands.add(_brand);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateBrand({
    required String name,
    required String imgUrl,
    required int id,
  }) async {
    try {
      BrandModel brand = await _brandService.updateBrand(
        name: name,
        imgUrl: imgUrl,
        id: id,
      );
      int index = _brands.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _brands[index] = brand;
      }
      _brand = brand;
      // _brands.add(_brand);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteBrand({
    required int id,
  }) async {
    try {
      await _brandService.deleteBrand(id: id);
      _brands.removeWhere((element) => element.id == id);
      // bool isDeleted = await _brandService.deleteBrand(id: id);
      // if (isDeleted) {
      //   _brands.removeWhere((element) => element.id == id);
      // }
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
