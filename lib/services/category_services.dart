import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';

import 'package:http/http.dart' as http;

class CategoryService {
  final String _baseUrl = '$baseUrl/api/categorys';
  // String baseUrl = 'http://localhost:8000/api';

  Future<List<CategoryModel>> getCategorys() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(_baseUrl), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      print('ini adalah List Data Category ${data}');
      return data
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }

    // print('ini adalah response body Category: ${response.body}');

    // List data = jsonDecode(response.body)['data'];
    // // print('ini adalah List Data $data');
    // _listCategorys.add(data);
    // print('ini adalah list category: $_listCategorys');
    // List<CategoryModel> categorys = [];
    // for (var item in data) {
    //   categorys.add(CategoryModel.fromJson(item));
    // }

    // // print('ini get data categorys $categorys');
    // return categorys;
  }
}
