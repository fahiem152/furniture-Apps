import 'dart:convert';

import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';

import 'package:http/http.dart' as http;

class BrandService {
  String baseUrl = 'https://8c07-103-105-28-175.ap.ngrok.io/api';

  // String baseUrl = 'http://localhost:8000/api';

  Future<List<BrandModel>> getBrands() async {
    var url = '$baseUrl/brand';
    // var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
    );

    print('ini adalah response body Brand: ${response.body}');

    List data = jsonDecode(response.body)['data'];
    print('ini adalah List Data $data');
    List<BrandModel> brands = [];
    for (var item in data) {
      brands.add(BrandModel.fromJson(item));
    }

    print('ini get data brands $brands');
    return brands;
  }
}
