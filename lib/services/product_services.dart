import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/product_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = '$baseUrl/api/products';
  // Future<List<ProductModel>> getProducts() async {
  //   // var headers = {'Content-Type': 'application/json'};

  //   var response = await http.get(
  //     Uri.parse(_baseUrl),
  //   );

  //   // print('ini adalah response body Product: ${response.body}');

  // //   List data = jsonDecode(response.body)['data'];
  // //   print('ini adalah List Data Product $data');
  // //   List<ProductModel> products = [];
  // //   for (var item in data) {
  // //     products.add(ProductModel.fromJson(item));
  // //   }

  // //   // print('ini get data products $products');
  // //   return products;
  // // }
  // }
  Future<List<ProductModel>> getProducts() async {
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
      print('ini adalah List Data Product ${data}');
      return data
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// import 'dart:convert';

// import 'package:furniture/models/product_model.dart';
// import 'package:furniture/services/api_services.dart';
// import 'package:http/http.dart' as http;

// class ProductService {
//   // String baseUrl = 'http://localhost:8000/api';

//   Future<List<ProductModel>> getProducts() async {
//     var url = '$baseUrl/product';
//     // var headers = {'Content-Type': 'application/json'};

//     var response = await http.get(
//       Uri.parse(url),
//     );

//     // print('ini adalah response body Product: ${response.body}');

//     List data = jsonDecode(response.body)['data'];
//     print('ini adalah List Data Product $data');
//     List<ProductModel> products = [];
//     for (var item in data) {
//       products.add(ProductModel.fromJson(item));
//     }

//     // print('ini get data products $products');
//     return products;
//   }

//   Future<ProductModel> addProduct(
//     String name,
//     String description,
//     int price,
//     String urlImage,
//     int categoryId,
//     int brandId,
//   ) async {
//     var url = '$baseUrl/product';
//     // var headers = {'Content-Type': 'application/json'};

//     var body = jsonEncode({
//       'name': name,
//       'description': description,
//       'price': price,
//       'urlImage': urlImage,
//       'category_id': categoryId,
//       'brand_id': brandId,
//     });
//     var response = await http.post(
//       Uri.parse(url),
//       body: body,
//     );
//     print('ini adalah response post: ${response.body}');
//     // final result = json.decode(response.body);
//     // print('Ini adalaha hasil result: $result');

//     final data = json.decode(response.body)['data'];
//     ProductModel product = ProductModel.fromJson(data);
//     print('ini adalah data: $data');
//     print('ini adalah product: $product');
//     return product;
//   }
// }
