// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ProfileModel ProfileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

class ProfileModel {
  ProfileModel({
    this.profile,
  });

  Profile profile;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    this.username,
    this.id,
    this.phone,
    this.address,
    this.storename,
    this.role,
    this.iat,
    this.exp,
  });

  String username;
  int id;
  String phone;
  String address;
  String storename;
  String role;
  int iat;
  int exp;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        username: json["username"],
        id: json["id"],
        phone: json["phone"],
        address: json["address"],
        storename: json["storename"],
        role: json["role"],
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "phone": phone,
        "address": address,
        "storename": storename,
        "role": role,
        "iat": iat,
        "exp": exp,
      };
}
