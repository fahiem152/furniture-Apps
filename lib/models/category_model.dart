class CategoryModel {
  final int id;
  final String name;
  final String category_img;
  final List<ListProductModel> product;

  CategoryModel({
    required this.id,
    required this.name,
    required this.category_img,
    required this.product,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        category_img: json['category_img'],
        product: List<ListProductModel>.from(
            json['product'].map((x) => ListProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category_img': category_img,
        'product': List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class ListProductModel {
  final String name;
  final int price;
  final String urlImage;

  ListProductModel({
    required this.name,
    required this.price,
    required this.urlImage,
  });

  factory ListProductModel.fromJson(Map<String, dynamic> json) =>
      ListProductModel(
        name: json['name'],
        price: json['price'],
        urlImage: json['urlImage'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'urlImage': urlImage,
      };
}
// // import 'dart:ffi';

// import 'package:furniture/models/product_model.dart';


// class CategoryModel {
//   int? id;
//   String? name;
//   String? category_img;
//   List<ListProductModel>? product;
//   // List? product;

//   CategoryModel({
//     this.id,
//     this.name,
//     this.category_img,
//     this.product,
//     // this.price,
//   });

//   CategoryModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     category_img = json['category_img'];
//     product = json['product'] != null
//         ? List<ListProductModel>.from(json['product']
//             .map((product) => ListProductModel.fromJson(product)))
//         : <ListProductModel>[];
//     // product = List<ListProductModel>.from(
//     //     json['product'].map((product) => ListProductModel.fromJson(product)));
//     // product = json['product']
//     //     .map<ListProductModel>((product) => ListProductModel.fromJson(product))
//     //     .toList();
//     // product = json['product'];

//     // products = (json['products'] as List)
//     //     .map((e) => ProductModel.fromJson(e))
//     //     .toList();
//     // products = json['products'] != null
//     //     ? (json['products'] as List)
//     //         .map((e) => ProductModel.fromJson(e))
//     //         .toList()
//     //     : null;
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category_img': category_img,
//       'product': List<dynamic>.from(product!.map((x) => x.toJson())),
//       // 'product': product?.map((products) => products.toJson()).toList(),
//       // 'product': product,

//       // 'product': product!.toJson()
//     };
//   }
// }

// class ListProductModel {
//   String? name;
//   int? price;
//   String? urlImage;
//   ListProductModel({this.name, this.price, this.urlImage});

//   ListProductModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'] as String;
//     price = json['price'] as int;
//     urlImage = json['urlImage'] as String;
//   }

//   // get length => null;
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'price': price,
//       'urlImage': urlImage,
//     };
//   }
// }
