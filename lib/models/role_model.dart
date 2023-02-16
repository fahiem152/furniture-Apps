import 'dart:convert';

class RoleModel {
  RoleModel({
    this.id,
    required this.name,

    //  this.createdAt,
    //  this.updatedAt,
  });

  int? id;
  final String name;
  // DateTime? createdAt;
  //  DateTime? updatedAt;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        name: json["name"],
        // createdAt: DateTime.parse(json["createdAt"]),
        // updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      // "createdAt": createdAt!.toIso8601String(),
      // "updatedAt": updatedAt!.toIso8601String(),
    };
  }
}
