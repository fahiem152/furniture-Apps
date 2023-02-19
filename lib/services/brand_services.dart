import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';

import 'package:http/http.dart' as http;

class BrandService {
  final String _baseUrl = '$baseUrl/api/brands';

  Future<List<BrandModel>> fetchBrand() async {
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
      return data.map<BrandModel>((json) => BrandModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<BrandModel> createBrand({
    required String name,
    required String imgUrl,
  }) async {
    String token = await getToken();
    final response = await http.post(Uri.parse(_baseUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "name": name,
          "brand_img": imgUrl,
        }));
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return BrandModel.fromJson(data);
    } else {
      throw Exception('Failed Create Brand');
    }
  }

  Future<BrandModel> updateBrand({
    required String name,
    required String imgUrl,
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
            "brand_img": imgUrl,
          },
        ));

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body)['data'];
      return BrandModel.fromJson(data);
    } else {
      throw Exception('Failed Update Brand');
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
