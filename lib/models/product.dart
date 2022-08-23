// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
    Product({
        required this.avaliable,
        required this.name,
        this.picture,
        required this.price,
    });

    bool avaliable;
    String name;
    String? picture;
    double price;

    factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Product.fromMap(Map<String, dynamic> json) => Product(
        avaliable: json["avaliable"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "avaliable": avaliable,
        "name": name,
        "picture": picture,
        "price": price,
    };
}
