import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final String urlImage;
  // final CategoryModel category;
  // final BrandModel brand;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.urlImage,
    // required this.category,
    // required this.brand,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        urlImage: json['urlImage'],
        // category: CategoryModel.fromJson(json['category']),
        // brand: BrandModel.fromJson(json['brand']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'urlImage': urlImage,
      // 'category': category.toJson(),
      // 'brand': brand.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
