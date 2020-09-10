// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ItemsModel ItemsModelFromJson(String str) =>
    ItemsModel.fromJson(json.decode(str));

class ItemsModel {
  ItemsModel({
    this.items,
  });

  List<Item> items;

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.photo,
    this.model,
    this.price,
    this.salePrice,
    this.description,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String photo;
  int model;
  int price;
  int salePrice;
  String description;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        model: json["model"],
        price: json["price"],
        salePrice: json["salePrice"],
        description: json["description"],
        categoryId: json["CategoryID"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "model": model,
        "price": price,
        "salePrice": salePrice,
        "description": description,
        "CategoryID": categoryId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
