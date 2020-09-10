// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ItemDetailsModel1 ItemDetailsModelFromJson(String str) =>
    ItemDetailsModel1.fromJson(json.decode(str));

class ItemDetailsModel1 {
  ItemDetailsModel1({
    this.items,
  });

  List<Item> items;

  factory ItemDetailsModel1.fromJson(Map<String, dynamic> json) =>
      ItemDetailsModel1(
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
    this.itemcolor,
    this.itemsize,
    this.photos,
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
  List<Itemcolor> itemcolor;
  List<Itemsize> itemsize;
  List<Photo> photos;

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
        itemcolor: List<Itemcolor>.from(
            json["itemcolor"].map((x) => Itemcolor.fromJson(x))),
        itemsize: List<Itemsize>.from(
            json["itemsize"].map((x) => Itemsize.fromJson(x))),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
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
        "itemcolor": List<dynamic>.from(itemcolor.map((x) => x.toJson())),
        "itemsize": List<dynamic>.from(itemsize.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
      };
}

class Itemcolor {
  Itemcolor({
    this.id,
    this.color,
  });

  int id;
  String color;

  factory Itemcolor.fromJson(Map<String, dynamic> json) => Itemcolor(
        id: json["id"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
      };
}

class Itemsize {
  Itemsize({
    this.itemsize,
    this.id,
  });

  String itemsize;
  int id;

  factory Itemsize.fromJson(Map<String, dynamic> json) => Itemsize(
        itemsize: json["itemsize"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "itemsize": itemsize,
        "id": id,
      };
}

class Photo {
  Photo({
    this.photo,
    this.id,
  });

  String photo;
  int id;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        photo: json["photo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "photo": photo,
        "id": id,
      };
}
