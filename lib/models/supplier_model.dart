import 'package:furniture/models/supplay_product_model.dart';

class SupplierModel {
  SupplierModel({
    this.id,
    required this.name,
    required this.address,
    required this.phone,
    this.supplayProduct,
  });

  int? id;
  final String name;
  final String address;
  final String phone;
  List<SupplayProductModel>? supplayProduct;

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
      id: json["id"],
      name: json["name"],
      address: json["address"],
      phone: json["phone"],
      supplayProduct: json["incomeProduct"] != null
          ? List<SupplayProductModel>.from(
              json["incomeProduct"].map((x) => SupplayProductModel.fromJson(x)))
          : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "incomeProduct":
            List<dynamic>.from(supplayProduct!.map((x) => x.toJson())),
      };
}
