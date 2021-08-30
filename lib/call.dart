
import 'dart:convert';

Call callFromJson(String str) => Call.fromJson(json.decode(str));

String callToJson(Call data) => json.encode(data.toJson());

class Call {
  Call({
    this.statusCode,
    this.success,
    this.message,
    this.phoneNumbers,
  });

  int statusCode;
  bool success;
  String message;
  List<String> phoneNumbers;

  factory Call.fromJson(Map<String, dynamic> json) => Call(
    statusCode: json["statusCode"] == null ? null : json["statusCode"],
    success: json["success"] == null ? null : json["success"],
    message: json["message"] == null ? null : json["message"],
    phoneNumbers: json["phoneNumbers"] == null ? null : List<String>.from(json["phoneNumbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode == null ? null : statusCode,
    "success": success == null ? null : success,
    "message": message == null ? null : message,
    "phoneNumbers": phoneNumbers == null ? null : List<dynamic>.from(phoneNumbers.map((x) => x)),
  };
}
