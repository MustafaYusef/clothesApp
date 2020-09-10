
import 'dart:convert';

OrderItemsModel orderItemsModelFromJson(String str) => OrderItemsModel.fromJson(json.decode(str));


class OrderItemsModel {
    OrderItemsModel({
        this.items,
    });

    List<ItemElement> items;

    factory OrderItemsModel.fromJson(Map<String, dynamic> json) => OrderItemsModel(
        items: List<ItemElement>.from(json["items"].map((x) => ItemElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class ItemElement {
    ItemElement({
        this.count,
        this.createdAt,
        this.size,
        this.color,
        this.item,
    });

    int count;
    DateTime createdAt;
    String size;
    String color;
    ItemItem item;

    factory ItemElement.fromJson(Map<String, dynamic> json) => ItemElement(
        count: json["count"],
        createdAt: DateTime.parse(json["createdAt"]),
        size: json["size"],
        color: json["color"],
        item: ItemItem.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "createdAt": createdAt.toIso8601String(),
        "size": size,
        "color": color,
        "item": item.toJson(),
    };
}

class ItemItem {
    ItemItem({
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

    factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
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