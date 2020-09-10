// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OffersModel OffersModelFromJson(String str) => OffersModel.fromJson(json.decode(str));



class OffersModel {
    OffersModel({
        this.offers,
    });

    List<Offer> offers;

    factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
    };
}

class Offer {
    Offer({
        this.id,
        this.name,
        this.photo,
        this.description,
        this.price,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String photo;
    String description;
    int price;
    DateTime createdAt;
    DateTime updatedAt;

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        description: json["description"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "description": description,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
