import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/supplier_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class SupplierService {
  final String _baseUrl = '$baseUrl/api/suppliers';
  Future<List<SupplierModel>> fetchSupplier() async {
    String token = await getToken();

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      print('ini adalah List Data Brand ${data}');
      return data
          .map<SupplierModel>((json) => SupplierModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SupplierModel> createSupplier({
    required String name,
    required String address,
    required String phone,
  }) async {
    String token = await getToken();
    final response = await http.post(Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": name,
          "address": address,
          "phone": phone,
        }));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return SupplierModel.fromJson(data);
    } else {
      throw Exception('Failed Create Supplier');
    }
  }

  Future<SupplierModel> updateSupplier({
    required String name,
    required String address,
    required String phone,
    required int id,
  }) async {
    String token = await getToken();
    final response = await http.put(Uri.parse('$_baseUrl/$id'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          {
            "name": name,
            "address": address,
            "phone": phone,
          },
        ));

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return SupplierModel.fromJson(data);
    } else {
      throw Exception('Failed Update Supplier');
    }
  }

  Future<void> deleteBrand({required int id}) async {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201) {
      print('Berhasil Delete Brand');
    } else {
      throw Exception('Failed Delete Brand');
    }
  }
}
