// To parse this JSON data, do
//
//     final album = albumFromJson(jsonString);

import 'dart:convert';

List<Album> albumFromJson(String str) =>
    List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumToJson(List<Album> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  Album({
    required this.id,
    required this.name,
    required this.describe,
    required this.imageName,
    required this.fojings,
  });

  int id;
  String name;
  String describe;
  String imageName;
  var fojings = [];

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"] ?? Null,
        name: json["name"] ?? "",
        describe: json["describe"] ?? "",
        imageName: json["imageName"] ?? "",
        fojings: json["fojings"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "describe": describe,
        "imageName": imageName,
      };
}
