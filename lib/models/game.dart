// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Game> welcomeFromJson(String str) => List<Game>.from(json.decode(str).map((x) => Game.fromJson(x)));

String welcomeToJson(List<Game> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Game {
    String model;
    int pk;
    Fields fields;

    Game({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String title;
    int price;
    String description;

    Fields({
        required this.user,
        required this.title,
        required this.price,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "title": title,
        "price": price,
        "description": description,
    };
}
