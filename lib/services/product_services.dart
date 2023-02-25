import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/product_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String _baseUrl = '$baseUrl/api/products';

  Future<List<ProductModel>> fetchProduct() async {
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

  Future<ProductModel> createProduct({
    required String name,
    required String description,
    required int brandId,
    required int categoryId,
    required int price,
    required String urlImage,
  }) async {
    String token = await getToken();
    final response = await http.post(
        Uri.parse(
          _baseUrl,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          {
            "name": name,
            "description": description,
            "brand_id": brandId,
            "category_id": categoryId,
            "price": price,
            "urlImage": urlImage,
          },
        ));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed Create Product');
    }
  }

  Future<ProductModel> updateProduct({
    required String name,
    required String description,
    required int brandId,
    required int categoryId,
    required int price,
    required String urlImage,
    required int id,
  }) async {
    String token = await getToken();
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(
        {
          "name": name,
          "description": description,
          "brand_id": brandId,
          "category_id": categoryId,
          "price": price,
          "urlImage": urlImage,
        },
      ),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return ProductModel.fromJson(data);
    } else {
      throw Exception('Failed Update Product');
    }
  }

  Future<void> deleteProduct({
    required int id,
  }) async {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201) {
      print('Berhasil Delete Product');
    } else {
      throw Exception('Failed Delete Product');
    }
  }
}
