import 'dart:convert';

import 'package:furniture/models/category_model.dart';

import 'package:http/http.dart' as http;

class CategoryService {
  String baseUrl = 'https://8c07-103-105-28-175.ap.ngrok.io/api';

  // String baseUrl = 'http://localhost:8000/api';

  Future<List<CategoryModel>> getCategorys() async {
    var url = '$baseUrl/category';
    // var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
    );

    print('ini adalah response body Category: ${response.body}');

    List data = jsonDecode(response.body)['data'];
    print('ini adalah List Data $data');
    List<CategoryModel> categorys = [];
    for (var item in data) {
      categorys.add(CategoryModel.fromJson(item));
    }

    print('ini get data categorys $categorys');
    return categorys;
  }
}
