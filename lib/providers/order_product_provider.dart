import 'package:flutter/material.dart';
import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/services/order_product_service.dart';

class OrderProductProvider with ChangeNotifier {
  OrderProductService _orderProductService = OrderProductService();

  List<OrderProductModel> _orderProducts = [];
  List<String> _deliveryTypes = ['TakeAway', 'Delivery'];
  List<String> _deliveryStatuses = [
    'Pending',
    'Delivered',
  ];
  String? _valDeliveryType;
  String? _valDeliveryStatus;

  OrderProductModel _orderProduct = OrderProductModel(
      productId: 0,
      quantity: 0,
      productPrice: 0,
      customerName: 'customerName',
      customerAddres: 'customerAddres',
      customerPhone: 'customerPhone',
      addressDetails: 'addressDetails');

  List<OrderProductModel> get orderProducts => _orderProducts;
  List<String> get deliveryTypes => _deliveryTypes;
  List<String> get deliveryStatuses => _deliveryStatuses;
  String? get valDeliveryType => _valDeliveryType;
  String? get valDeliveryStatus => _valDeliveryStatus;

  void setDeliveryType(String? value) {
    _valDeliveryType = value;
    notifyListeners();
  }

  void setDeliveryStatus(String? value) {
    _valDeliveryStatus = value;
    notifyListeners();
  }

  Future<void> fetchOrderProduct() async {
    try {
      _orderProducts = await _orderProductService.fetchOrderProduct();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchOrderProductByDeliveryTypeDeliveryStatus({
    required String deliveryType,
    required String deliveryStatus,
  }) async {
    try {
      _orderProducts = await _orderProductService
          .fetchOrderProductByDeliveryTypeDeliveryStatus(
              deliveryType: deliveryType, deliveryStatus: deliveryStatus);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> createOrderProduct({
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
    try {
      OrderProductModel orderProduct =
          await _orderProductService.createOrderProduct(
        productId: productId,
        quantity: quantity,
        productPrice: productPrice,
        customerName: customerName,
        customerAddres: customerAddres,
        customerPhone: customerPhone,
        addressDetails: addressDetails,
        deliveryType: deliveryType,
        deliveryStatus: deliveryStatus,
      );
      _orderProduct = orderProduct;
      _orderProducts.add(_orderProduct);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateOrderProduct({
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
    try {
      OrderProductModel orderProduct =
          await _orderProductService.updateOrderProduct(
        productId: productId,
        quantity: quantity,
        productPrice: productPrice,
        customerName: customerName,
        customerAddres: customerAddres,
        customerPhone: customerPhone,
        addressDetails: addressDetails,
        deliveryType: deliveryType,
        deliveryStatus: deliveryStatus,
        id: id,
      );
      int index = _orderProducts.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _orderProducts[index] = orderProduct;
      }

      _orderProduct = orderProduct;

      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteOrderProduct({required int id}) async {
    try {
      await _orderProductService.deleteOrderProduct(id: id);
      _orderProducts.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
