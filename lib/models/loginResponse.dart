// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginResModel welcomeFromJson(String str) => LoginResModel.fromJson(json.decode(str));


class LoginResModel {
    LoginResModel({
        this.status,
        this.token,
        this.expire,
    });

    String status;
    String token;
    int expire;

    factory LoginResModel.fromJson(Map<String, dynamic> json) => LoginResModel(
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
