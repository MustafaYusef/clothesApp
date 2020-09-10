// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RegesterResModel RegesterResModelFromJson(String str) =>
    RegesterResModel.fromJson(json.decode(str));

class RegesterResModel {
  RegesterResModel({
    this.message,
  });

  String message;

  factory RegesterResModel.fromJson(Map<String, dynamic> json) =>
      RegesterResModel(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
