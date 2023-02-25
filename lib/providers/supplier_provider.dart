import 'package:flutter/material.dart';
import 'package:furniture/models/supplier_model.dart';
import 'package:furniture/services/supplier_service.dart';

class SupplierProvider with ChangeNotifier {
  SupplierService _supplierService = SupplierService();
  List<SupplierModel> _suppliers = [];
  SupplierModel _supplier = SupplierModel(name: '', address: '', phone: '');

  List<SupplierModel> get suppliers => _suppliers;

  Future<void> fetchSupplier() async {
    try {
      _suppliers = await _supplierService.fetchSupplier();
      notifyListeners();
    } catch (e) {
      print(3);
    }
  }

  Future<bool> createSupplier({
    required String name,
    required String address,
    required String phone,
  }) async {
    try {
      SupplierModel supplier = await _supplierService.createSupplier(
        name: name,
        address: address,
        phone: phone,
      );
      _supplier = supplier;
      _suppliers.add(_supplier);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateSupplier({
    required String name,
    required String address,
    required String phone,
    required int id,
  }) async {
    try {
      SupplierModel supplier = await _supplierService.updateSupplier(
        name: name,
        address: address,
        phone: phone,
        id: id,
      );
      int index = _suppliers.indexWhere((element) => element.id == id);
      if (index >= 0) {
        _suppliers[index] = supplier;
      }
      _supplier = supplier;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteSupplier({
    required int id,
  }) async {
    try {
      await _supplierService.deleteBrand(id: id);

      suppliers.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
