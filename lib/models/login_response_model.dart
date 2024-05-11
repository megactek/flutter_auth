import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final Data? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.date,
    required this.id,
    required this.token,
  });

  final String? username;
  final String? email;
  final DateTime? date;
  final String? id;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      username: json["username"],
      email: json["email"],
      date: DateTime.tryParse(json["date"] ?? ""),
      id: json["id"],
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "date": date?.toIso8601String(),
        "id": id,
        "token": token,
      };
}
