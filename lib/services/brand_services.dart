import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';

import 'package:http/http.dart' as http;

class BrandService {
  final String _baseUrl = '$baseUrl/api/brands';

  Future<List<BrandModel>> getBrands() async {
    String token = await getToken();

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      print('ini adalah List Data Brand ${data}');
      return data.map<BrandModel>((json) => BrandModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }

    // print('ini adalah response body Brand: ${response.body}');

    // List data = jsonDecode(response.body)['data'];
    // print('ini adalah List Data Brand $data');
    // List<BrandModel> brands = [];
    // for (var item in data) {
    //   brands.add(BrandModel.fromJson(item));
    // }

    // // print('ini get data brands $brands');
    // return brands;
  }
}
