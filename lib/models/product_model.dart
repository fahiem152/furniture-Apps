import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';

class ProductModel {
  int? id;
  final String name;
  final String description;
  final int brandId;
  final int categoryId;
  final int price;
  final String urlImage;
  int? stock;
  CategoryModel? category;
  BrandModel? brand;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.urlImage,
    required this.brandId,
    required this.categoryId,
    this.stock,
    this.category,
    this.brand,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        urlImage: json['urlImage'],
        brandId: json['brand_id'],
        categoryId: json['category_id'],
        stock: json['stock'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        brand:
            json['brand'] != null ? BrandModel.fromJson(json['brand']) : null,
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'urlImage': urlImage,
      'brand_id': brandId,
      'category_id': categoryId,
      'stock': stock,
      'category': category!.toJson(),
      'brand': brand!.toJson(),
      // // 'category': category.toJson(),
      // // 'brand': brand.toJson(),
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
    };
  }
}
