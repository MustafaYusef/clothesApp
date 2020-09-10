// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SlidersModel SlidersModelFromJson(String str) => SlidersModel.fromJson(json.decode(str));



class SlidersModel {
    SlidersModel({
        this.slider,
    });

    List<Slider> slider;

    factory SlidersModel.fromJson(Map<String, dynamic> json) => SlidersModel(
        slider: List<Slider>.from(json["slider"].map((x) => Slider.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "slider": List<dynamic>.from(slider.map((x) => x.toJson())),
    };
}

class Slider {
    Slider({
        this.id,
        this.photo,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String photo;
    DateTime createdAt;
    DateTime updatedAt;

    factory Slider.fromJson(Map<String, dynamic> json) => Slider(
        id: json["id"],
        photo: json["photo"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
