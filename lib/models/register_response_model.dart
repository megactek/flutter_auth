import 'dart:convert';

RegisterResponseModel registerResponseJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final Data? data;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    required this.username,
    required this.email,
    required this.date,
    required this.id,
  });

  final String? username;
  final String? email;
  final DateTime? date;
  final String? id;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      username: json["username"],
      email: json["email"],
      date: DateTime.tryParse(json["date"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "date": date?.toIso8601String(),
        "id": id,
      };
}
