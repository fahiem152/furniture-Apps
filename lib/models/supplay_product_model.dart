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
  });

  int? id;
  final int productId;
  final int supplierId;
  final int price;
  final int quantity;
  int? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;

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
      };
}
