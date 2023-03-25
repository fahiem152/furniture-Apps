import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/chart_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ChartService {
  final String _baseUrl = '$baseUrl/api/orders';
  // Future<List<ChartOrderCategoryModel>> fetchChartOrderCategoryModel() async {
  //   String token = await getToken();
  //   String startDate = '2023-02-11';
  //   String endDate = '2023-03-11';
  //   String categoryId = '2';

  //   final response = await http.get(
  //       Uri.parse(
  //         '$_baseUrl/category/date/$startDate?enddate=$endDate&category_id=$categoryId',
  //       ),
  //       headers: {
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //         'Authorization': 'Bearer $token',
  //       });
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body)['data'];
  //     return data
  //         .map<ChartOrderCategoryModel>(
  //             (json) => ChartOrderCategoryModel.fromJson(json))
  //         .toList();
  //   } else {
  //     throw Exception('Failed to load data CahrtCategoryModel');
  //   }
  // }

  Future<List<ChartOrderCategoriesModel>> fetchChartOrderCategories({
    required String startDate,
    required String endDate,
    required int categoryId,
  }) async {
    String token = await getToken();
    // String startDate = '2023-02-11';
    // String endDate = '2023-03-12';

    final response = await http.get(
        Uri.parse(
          categoryId != 0
              ? '$_baseUrl/category/date/$startDate?enddate=$endDate&category_id=$categoryId'
              : '$_baseUrl/category/date/$startDate?enddate=$endDate',
          // '$_baseUrl/category/date/$startDate?enddate=$endDate&category_id=$categoryId',
          // '$_baseUrl/category/date/$startDate?enddate=$endDate',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        });
    print(response.body);
    if (response.statusCode == 200) {
      final data = (categoryId == 0)
          ? jsonDecode(response.body)['data']
          : jsonDecode(response.body)['data']['orders'];
      return data
          .map<ChartOrderCategoriesModel>(
              (json) => ChartOrderCategoriesModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data CahrtCategoriesModel');
    }
  }
}
