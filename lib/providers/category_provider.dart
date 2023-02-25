import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/category_services.dart';

class CategoryProvider with ChangeNotifier {
  CategoryService _categoryService = CategoryService();
  List<CategoryModel> _categorys = [];
  int? _valueCategory;
  CategoryModel _category = CategoryModel(name: '', categoryImg: '');

  List<CategoryModel> get categorys => _categorys;
  int? get valueCategory => _valueCategory;

  void setValueCategory(int? newValue) {
    _valueCategory = newValue;
    notifyListeners();
  }

  Future<void> fetchCategory() async {
    try {
      _categorys = await _categoryService.fetchCategory();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createCategory({
    required String name,
    required String imgUrl,
  }) async {
    try {
      CategoryModel category = await _categoryService.createCategory(
        name: name,
        imgUrl: imgUrl,
      );
      _category = category;
      _categorys.add(_category);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateCategory({
    required String name,
    required String imgUrl,
    required int id,
  }) async {
    try {
      CategoryModel category = await _categoryService.updateCategory(
        name: name,
        imgUrl: imgUrl,
        id: id,
      );
      int index = _categorys.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _categorys[index] = category;
      }
      _category = category;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteCategory({
    required int id,
  }) async {
    try {
      await _categoryService.deleteCategory(id: id);
      _categorys.removeWhere((element) => element.id == id);

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
