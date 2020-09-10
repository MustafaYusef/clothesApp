// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CatagoryModel CatagoryModelFromJson(String str) => CatagoryModel.fromJson(json.decode(str));


class CatagoryModel {
    CatagoryModel({
        this.category,
    });

    List<Category> category;

    factory CatagoryModel.fromJson(Map<String, dynamic> json) => CatagoryModel(
        category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.photo,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String photo;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        photo: json["photo"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}