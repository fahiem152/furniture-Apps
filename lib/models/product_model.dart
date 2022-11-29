import 'dart:convert';

import 'package:furniture/models/brand_model.dart';
import 'package:furniture/models/category_model.dart';

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  String? urlImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel? category;
  // BrandModel? brand;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.urlImage,
    this.createdAt,
    this.updatedAt,
    this.category,
    // this.brand,
  });
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = int.parse(json['price'].toString());
    urlImage = json['urlImage'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updatedAt']);
    category = CategoryModel.fromJson(json['category']);
    // brand = BrandModel.fromJson(json['brand']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'created_at': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'category': category?.toJson(),
      // 'brand': brand?.toJson()
    };
  }
}
