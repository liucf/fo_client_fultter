// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
  Player({
    required this.id,
    required this.name,
    required this.url,
    required this.album_id,
    required this.albumImage,
  });

  int id;
  String name;
  String url;
  int album_id;
  String albumImage;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        album_id: json["album_id"] == null ? null : json["album_id"],
        albumImage: json["album_image"] == null ? null : json["album_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "album_id": album_id == null ? null : album_id,
        "album_image": albumImage == null ? null : albumImage,
      };
}
