import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/category_services.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categorys = [];

  List<CategoryModel> get categorys => _categorys;

  set categorys(List<CategoryModel> categorys) {
    _categorys = categorys;
    notifyListeners();
  }

  Future<void> geCategorys() async {
    try {
      List<CategoryModel> categorys = await CategoryService().getCategorys();
      _categorys = categorys;
    } catch (e) {
      print(e);
    }
  }
}
