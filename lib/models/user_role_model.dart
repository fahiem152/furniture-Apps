import 'package:furniture/models/role_model.dart';
import 'package:furniture/models/user_model.dart';

class UserRoleModel {
  int? id;
  // int? user_id;
  // int? role_id;
  final int authUserId;
  final int authRoleId;

  UserModel? user;
  RoleModel? role;
  UserRoleModel({
    this.id,
    this.user,
    this.role,
    // this.user_id,
    // this.role_id,
    required this.authRoleId,
    required this.authUserId,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        id: json["id"],
        authUserId: json["auth_user_id"],
        authRoleId: json["auth_role_id"],
        user: UserModel.fromJson(json["auth_user"]),
        role: RoleModel.fromJson(json["auth_role"]),
        // user_id: json["user_id"],
        // role_id: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "auth_user_id": authUserId,
        "auth_role_id": authRoleId,
        "auth_user": user!.toJson(),
        "auth_role": role!.toJson(),
        // "user_id": user_id,
        // "role_id": role_id,
      };
}
