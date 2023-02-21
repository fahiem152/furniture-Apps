import 'package:furniture/models/product_model.dart';

class CategoryModel {
  int? id;
  final String name;
  final String categoryImg;
  List<ProductModel>? product;

  CategoryModel({
    this.id,
    required this.name,
    required this.categoryImg,
    this.product,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json['id'],
      name: json['name'],
      categoryImg: json['category_img'],
      product: json["product"] != null
          ? List<ProductModel>.from(
              json["product"].map((x) => ProductModel.fromJson(x)))
          : <ProductModel>[]);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category_img': categoryImg,
        'product': List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}
