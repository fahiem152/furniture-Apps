import 'package:furniture/models/category_model.dart';

class BrandModel {
  int? id;
  String? name;
  String? brand_img;
  List<ListProductModel>? product;

  BrandModel({
    this.id,
    this.name,
    this.brand_img,
    this.product,
  });

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    brand_img = json['brand_img'];
    product = json['product'] != null
        ? List<ListProductModel>.from(json['product']
            .map((product) => ListProductModel.fromJson(product)))
        : <ListProductModel>[];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand_img': brand_img,
      'product': List<dynamic>.from(product!.map((x) => x.toJson())),
    };
  }
}
