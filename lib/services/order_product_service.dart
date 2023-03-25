import 'dart:convert';
import 'dart:io';

import 'package:furniture/models/category_model.dart';
import 'package:furniture/models/chart_model.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/services/api_services.dart';
import 'package:furniture/services/storage_service.dart';
import 'package:http/http.dart' as http;

class OrderProductService {
  final String _baseUrl = '$baseUrl/api/orders';
  Future<List<OrderProductModel>> fetchOrderProduct() async {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(
          _baseUrl,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        });
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data
          .map<OrderProductModel>((json) => OrderProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data order product');
    }
  }

  Future<List<OrderProductModel>> fetchOrderProductByUser({
    required int userId,
    required int page,
    required int perpage,
    required String deliveryStatus,
  }) async {
    String token = await getToken();
    final response = await http.get(
        Uri.parse(
          // '$_baseUrl/$userId?$deliveryType=true&$deliveryStatus=true&page=$page&perpage=$perpage',
          // '$_baseUrl/$userId?$deliveryStatus=true&page=$page&perpage=$perpage',
          '$_baseUrl/$userId?$deliveryStatus=true',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        });
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return data
          .map<OrderProductModel>((json) => OrderProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data order product');
    }
  }

  Future<List<OrderProductModel>>
      fetchOrderProductByDeliveryTypeDeliveryStatus({
    required String deliveryType,
    required String deliveryStatus,
  }) async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(
        _baseUrl +
            '?' +
            deliveryType +
            '=true' +
            '&' +
            deliveryStatus +
            '=true',
      ),
      headers: {
        HttpHeaders.contentTypeHeader: 'aplication/json',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      print('ini adalah List Data Product ${data}');
      return data
          .map<OrderProductModel>((json) => OrderProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<OrderProductModel> createOrderProduct({
    // required int authUserId,
    required int productId,
    required int quantity,
    required int productPrice,
    required String customerName,
    required String customerAddres,
    required String customerPhone,
    required String addressDetails,
    required String deliveryType,
    required String deliveryStatus,
  }) async {
    String token = await getToken();
    String userId = await getUserId();
    final response = await http.post(
        Uri.parse(
          _baseUrl,
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "auth_user_id": int.parse(userId),
          "product_id": productId,
          "product_price": productPrice,
          "quantity": quantity,
          "customer_name": customerName,
          "customer_addres": customerAddres,
          "customer_phone": customerPhone,
          "address_details": addressDetails,
          "delivery_type": deliveryType,
          "delivery_status": deliveryStatus,
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return OrderProductModel.fromJson(data);
    } else {
      throw Exception('Failed Create Order Product');
    }
  }

  Future<OrderProductModel> updateOrderProduct({
    required int productId,
    required int quantity,
    required int productPrice,
    required String customerName,
    required String customerAddres,
    required String customerPhone,
    required String addressDetails,
    required String deliveryType,
    required String deliveryStatus,
    required int id,
  }) async {
    String token = await getToken();
    String userId = await getUserId();
    final response = await http.put(
        Uri.parse(
          '$_baseUrl/$id',
        ),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "auth_user_id": int.parse(userId),
          "product_id": productId,
          "product_price": productPrice,
          "quantity": quantity,
          "customer_name": customerName,
          "customer_addres": customerAddres,
          "customer_phone": customerPhone,
          "address_details": addressDetails,
          "delivery_type": deliveryType,
          "delivery_status": deliveryStatus,
        }));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return OrderProductModel.fromJson(data);
    } else {
      throw Exception('Failed Create Order Product');
    }
  }

  Future<void> deleteOrderProduct({required int id}) async {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      print('Berhasil Delete Order Product');
    } else {
      throw Exception('Failed Delete Order Product');
    }
  }
}
