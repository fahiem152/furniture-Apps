import 'package:furniture/models/product_model.dart';
import 'package:furniture/models/user_model.dart';

class OrderProductModel {
  OrderProductModel({
    this.id,
    this.authUserId,
    required this.productId,
    required this.quantity,
    required this.productPrice,
    this.totalPrice,
    required this.customerName,
    required this.customerAddres,
    required this.customerPhone,
    required this.addressDetails,
    this.deliveryType,
    this.deliveryStatus,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.user,
  });

  int? id;
  int? authUserId;
  int productId;
  int quantity;
  int productPrice;
  int? totalPrice;
  String customerName;
  String customerAddres;
  String customerPhone;
  String addressDetails;
  String? deliveryType;
  String? deliveryStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProductModel? product;
  UserModel? user;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) =>
      OrderProductModel(
        id: json["id"],
        authUserId: json["auth_user_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        productPrice: json["product_price"],
        totalPrice: json["total_price"],
        customerName: json["customer_name"],
        customerAddres: json["customer_addres"],
        customerPhone: json["customer_phone"],
        addressDetails: json["address_details"],
        deliveryType: json["delivery_type"],
        deliveryStatus: json["delivery_status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        product: json["product"] != null
            ? ProductModel.fromJson(json["product"])
            : null,
        user: json["auth_user"] != null
            ? UserModel.fromJson(json["auth_user"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "auth_user_id": authUserId,
        "product_id": productId,
        "quantity": quantity,
        "product_price": productPrice,
        "total_price": totalPrice,
        "customer_name": customerName,
        "customer_addres": customerAddres,
        "customer_phone": customerPhone,
        "address_details": addressDetails,
        "delivery_type": deliveryType,
        "delivery_status": deliveryStatus,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "product": product!.toJson(),
      };
}
