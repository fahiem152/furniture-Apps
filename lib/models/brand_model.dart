import 'package:furniture/models/category_model.dart';
import 'package:furniture/models/product_model.dart';

class BrandModel {
  int? id;
  final String name;
  final String brandImg;
  List<ProductModel>? product;

  BrandModel({
    this.id,
    required this.name,
    required this.brandImg,
    this.product,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json['id'],
        name: json['name'],
        brandImg: json['brand_img'],
        // product: List<ProductModel>.from(
        //   json['product'].map(
        //     (x) => ListProductModel.fromJson(x),
        //   ),
        // ),
        product: json["product"] != null
            ? List<ProductModel>.from(
                json["product"].map((x) => ProductModel.fromJson(x)))
            : <ProductModel>[]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand_img': brandImg,
      'product': List<dynamic>.from(product!.map((x) => x.toJson())),
    };
  }
}
