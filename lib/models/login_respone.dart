class LoginResponeModel {
  final String token;

  LoginResponeModel({required this.token});
  factory LoginResponeModel.fromJson(Map<String, dynamic> json) {
    return LoginResponeModel(
      token: json['token'],
    );
  }
}
