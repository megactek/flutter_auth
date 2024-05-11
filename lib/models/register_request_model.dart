class RegisterRequestModel {
  RegisterRequestModel({
    required this.username,
    required this.password,
    required this.email,
  });

  final String? username;
  final String? password;
  final String? email;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    return RegisterRequestModel(
      username: json["username"],
      password: json["password"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
      };
}
