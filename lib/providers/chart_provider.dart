import 'package:flutter/material.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/models/chart_model.dart';
import 'package:furniture/services/chart_service.dart';
import 'package:furniture/services/order_product_service.dart';

class ChartProvider with ChangeNotifier {
  ChartService _chartService = ChartService();
  // List<ChartOrderCategoryModel> _chartOrderCategory = [];
  // List<ChartOrderCategoryModel> get chartOrderCategory => _chartOrderCategory;
  List<ChartOrderCategoriesModel> _chartOrderCategories = [];
  List<ChartOrderCategoriesModel> get chartOrderCategories =>
      _chartOrderCategories;
  // Future<void> fetchchartOrderCategoryModel() async {
  //   try {
  //     _chartOrderCategory = await _chartService.fetchChartOrderCategoryModel();
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> fetchChartOrderCategories({
    required String startDate,
    required String endDate,
    required int categoryId,
  }) async {
    try {
      _chartOrderCategories = await _chartService.fetchChartOrderCategories(
        startDate: startDate,
        endDate: endDate,
        categoryId: categoryId,
      );
      notifyListeners();
    } catch (e) {
      print('fetchChartOrderCategories: $e');
    }
  }
}
