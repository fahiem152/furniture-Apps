import 'dart:convert';

import 'package:furniture/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = 'https://8c07-103-105-28-175.ap.ngrok.io/api';

  // String baseUrl = 'http://localhost:8000/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/product';
    // var headers = {'Content-Type': 'application/json'};

    var response = await http.get(
      Uri.parse(url),
    );

    print('ini adalah response body Product: ${response.body}');

    List data = jsonDecode(response.body)['data'];
    print('ini adalah List Data $data');
    List<ProductModel> products = [];
    for (var item in data) {
      products.add(ProductModel.fromJson(item));
    }

    print('ini get data products $products');
    return products;
    // if (response.statusCode == 200) {
    //   List data = jsonDecode(response.body)['data'];
    //   List<ProductModel> products = [];
    //   for (var item in data) {
    //     products.add(ProductModel.fromJson(item));
    //   }
    //   print('get data products $products');
    //   return products;
    // } else {
    //   throw Exception('Gagal Get Products!');
    // }
  }
}
