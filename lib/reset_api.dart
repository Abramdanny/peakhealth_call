// To parse this JSON data, do
//
//     final reset = resetFromJson(jsonString);

import 'dart:convert';

Reset resetFromJson(String str) => Reset.fromJson(json.decode(str));

String resetToJson(Reset data) => json.encode(data.toJson());

class Reset {
  Reset({
    this.statusCode,
    this.message,
  });

  bool statusCode;
  String message;

  factory Reset.fromJson(Map<String, dynamic> json) => Reset(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "message": message == null ? null : message,
  };
}
