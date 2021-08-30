// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.statusCode,
    this.success,
    this.message,
    this.token,
  });

  int statusCode;
  bool success;
  String message;
  String token;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "token": token == null ? null : token,
  };
}
