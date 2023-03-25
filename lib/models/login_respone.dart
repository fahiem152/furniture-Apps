class LoginResponeModel {
  String? token;
  String? error;

  LoginResponeModel({this.token, this.error});
  factory LoginResponeModel.fromJson(Map<String, dynamic> json) {
    return LoginResponeModel(
      token: json['token'],
      error: json['error'],
    );
  }
}
