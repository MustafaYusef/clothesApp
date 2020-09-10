// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

OrdersModel OrdersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

class OrdersModel {
  OrdersModel({
    this.orders,
  });

  List<Order> orders;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.id,
    this.totalptice,
    this.userid,
    this.state,
    this.createdAt,
    this.userId,
  });

  int id;
  int totalptice;
  int userid;
  String state;
  DateTime createdAt;
  int userId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        totalptice: json["totalptice"],
        userid: json["userid"],
        state: json["state"],
        createdAt: DateTime.parse(json["createdAt"]),
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "totalptice": totalptice,
        "userid": userid,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "UserId": userId,
      };
}

// enum State { COMPLETED, PROCCESSING, NEW }

// final stateValues = EnumValues({
//   "completed": State.COMPLETED,
//   "new": State.NEW,
//   "proccessing": State.PROCCESSING
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
