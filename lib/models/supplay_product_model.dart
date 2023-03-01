import 'package:furniture/models/product_model.dart';
import 'package:furniture/models/supplier_model.dart';

class SupplayProductModel {
  SupplayProductModel({
    this.id,
    required this.productId,
    required this.supplierId,
    required this.price,
    required this.quantity,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.supplier,
  });

  int? id;
  final int productId;
  final int supplierId;
  final int price;
  final int quantity;
  int? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductModel? product;
  SupplierModel? supplier;

  factory SupplayProductModel.fromJson(Map<String, dynamic> json) =>
      SupplayProductModel(
        id: json["id"],
        productId: json["product_id"],
        supplierId: json["supplier_id"],
        price: json["price"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: json["product"] != null
            ? ProductModel.fromJson(json["product"])
            // : ProductModel(
            //     name: 'jashdjha',
            //     description: 'description',
            //     price: 0,
            //     urlImage: 'urlImage',
            //     brandId: 0,
            //     categoryId: 0),
            : null,
        supplier: json["supplier"] != null
            ? SupplierModel.fromJson(json["supplier"])
            : null,
        // : SupplierModel(
        //     name: 'unokwons', address: 'address', phone: 'phone'),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "supplier_id": supplierId,
        "price": price,
        "quantity": quantity,
        "total_price": totalPrice,
        "createdAt": createdAt.toString(),
        "updatedAt": updatedAt.toString(),
        "product": product!.toJson(),
        "supplier": supplier!.toJson(),
      };
}
