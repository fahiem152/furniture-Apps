import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/supplay_product_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class SupplayProductService {
  final String _baseUrl = '$baseUrl/api/incomeProducts';

  Future<List<SupplayProductModel>> fetchSupplayProduct() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(_baseUrl), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data
          .map<SupplayProductModel>(
              (json) => SupplayProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data supplay product');
    }
  }

  Future<SupplayProductModel> createSupplayProduct({
    required int productId,
    required int supplierId,
    required int price,
    required int quantity,
  }) async {
    String token = await getToken();
    final response = await http.post(Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "product_id": productId,
          "supplier_id": supplierId,
          "price": price,
          "quantity": quantity,
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return SupplayProductModel.fromJson(data);
    } else {
      throw Exception('Failed Create Supplay Product');
    }
  }

  Future<SupplayProductModel> updateSupplayProduct({
    required int productId,
    required int supplierId,
    required int price,
    required int quantity,
    required int id,
  }) async {
    String token = await getToken();
    final response = await http.put(
        Uri.parse(
          '$_baseUrl/$id',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "product_id": productId,
          "supplier_id": supplierId,
          "price": price,
          "quantity": quantity,
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return SupplayProductModel.fromJson(data);
    } else {
      throw Exception('Failed Update Supplay Product');
    }
  }

  Future<void> deleteSupplayProduct({required int id}) async {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Berhasil Delete Supplay Product');
    } else {
      throw Exception('Failed Delete Supplay Product');
    }
  }
}
