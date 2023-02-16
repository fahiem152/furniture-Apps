import 'package:furniture/models/category_model.dart';

class BrandModel {
  final int id;
  final String name;
  final String brand_img;
  final List<ListProductModel> product;

  BrandModel({
    required this.id,
    required this.name,
    required this.brand_img,
    required this.product,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'],
      name: json['name'],
      brand_img: json['brand_img'],
      product: List<ListProductModel>.from(
          json['product'].map((x) => ListProductModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand_img': brand_img,
      'product': List<dynamic>.from(product.map((x) => x.toJson())),
    };
  }
}


// import 'package:furniture/models/category_model.dart';

// class BrandModel {
//   int? id;
//   String? name;
//   String? brand_img;
//   List<ListProductModel>? product;

//   BrandModel({
//     this.id,
//     this.name,
//     this.brand_img,
//     this.product,
//   });

//   BrandModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     brand_img = json['brand_img'];
//     product = json['product'] != null
//         ? List<ListProductModel>.from(json['product']
//             .map((product) => ListProductModel.fromJson(product)))
//         : <ListProductModel>[];
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'brand_img': brand_img,
//       'product': List<dynamic>.from(product!.map((x) => x.toJson())),
//     };
//   }
// }
