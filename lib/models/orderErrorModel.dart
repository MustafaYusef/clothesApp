// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) => ErrorModel.fromJson(json.decode(str));


class ErrorModel {
    ErrorModel({
        this.error,
    });

    String error;

    factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "error": error,
    };
}