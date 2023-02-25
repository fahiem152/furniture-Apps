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

  // factory UserRoleModel.fromJson(Map<String, dynamic> json) {
  //   var authUser = json['auth_user'];
  //   var authRole = json['auth_role'];

  //   return UserRoleModel(
  //       id: json["id"],
  //       authUserId: json["auth_user_id"],
  //       authRoleId: json["auth_role_id"],
  //       user: authUser != null
  //           ? UserModel.fromJson(authUser)
  //           : UserModel(name: 'name', email: 'email', password: 'password'),
  //       role: authRole != null
  //           ? RoleModel.fromJson(authRole)
  //           : RoleModel(name: 'name'));
  // }

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        id: json["id"],
        authUserId: json["auth_user_id"],
        authRoleId: json["auth_role_id"],
        user: json["auth_user"] != null
            ? UserModel.fromJson(json["auth_user"])
            : null,
        // role: RoleModel.fromJson(json['auth_role'])

        role: json["auth_role"] != null
            ? RoleModel.fromJson(json["auth_role"])
            : null,
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
