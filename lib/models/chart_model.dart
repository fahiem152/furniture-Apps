import 'package:furniture/models/order_product_model.dart';
import 'package:furniture/models/product_model.dart';

// class ChartOrderCategoryModel {
//   ChartOrderCategoryModel({
//     required this.productId,
//     required this.quantity,
//     this.product,
//   });

//   final int productId;
//   final int quantity;
//   ProductModel? product;

//   factory ChartOrderCategoryModel.fromJson(Map<String, dynamic> json) =>
//       ChartOrderCategoryModel(
//         productId: json["product_id"],
//         quantity: json["quantity"],
//         product: ProductModel.fromJson(json["product"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "product_id": productId,
//         "quantity": quantity,
//         "product": product!.toJson(),
//       };
// }

class ChartOrderCategoriesModel {
  String? name;
  int? quantity;
  List<OrderProductModel>? orders;
  String? persen;
  int? productId;
  ProductModel? product;

  ChartOrderCategoriesModel({
    this.name,
    this.quantity,
    this.orders,
    this.persen,
    this.productId,
    this.product,
  });

  factory ChartOrderCategoriesModel.fromJson(Map<String, dynamic> json) =>
      ChartOrderCategoriesModel(
        name: json["name"],
        quantity: json["quantity"],
        persen: json["persen"],
        productId: json["product_id"],
        product: json["product"] != null
            ? ProductModel.fromJson(json["product"])
            : null,
        orders: json["orders"] != null
            ? List<OrderProductModel>.from(
                json["orders"].map((x) => OrderProductModel.fromJson(x)))
            : <OrderProductModel>[],
      );

  Map<String, dynamic> toJson() => {
        "name": name!,
        "quantity": quantity!,
        "persen": persen!,
        "orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
        "product_id": productId!,
        "product": product!.toJson(),
      };
}
