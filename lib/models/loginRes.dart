// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginRes LoginResFromJson(String str) => LoginRes.fromJson(json.decode(str));

class LoginRes {
  LoginRes({
    this.status,
    this.token,
    this.expire,
  });

  String status;
  String token;
  int expire;

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        status: json["status"],
        token: json["token"],
        expire: json["expire"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "expire": expire,
      };
}
