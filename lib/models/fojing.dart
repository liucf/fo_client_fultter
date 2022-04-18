// To parse this JSON data, do
//
//     final fojing = fojingFromJson(jsonString);

import 'dart:convert';

List<FojingElement> fojingFromJson(String str) => List<FojingElement>.from(
    json.decode(str).map((x) => FojingElement.fromJson(x)));

// Fojing fojingFromJson(String str) => Fojing.fromJson(json.decode(str));

String fojingToJson(Fojing data) => json.encode(data.toJson());

class Fojing {
  Fojing({
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
  List<FojingElement> fojings;

  factory Fojing.fromJson(Map<String, dynamic> json) => Fojing(
        id: json["id"],
        name: json["name"],
        describe: json["describe"],
        imageName: json["imageName"],
        fojings: json["fojings"] == null
            ? []
            : List<FojingElement>.from(
                json["fojings"].map((x) => FojingElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "describe": describe,
        "imageName": imageName,
        "fojings": fojings.isEmpty
            ? []
            : List<dynamic>.from(fojings.map((x) => x.toJson())),
      };
}

class FojingElement {
  FojingElement({
    required this.id,
    required this.albumId,
    required this.name,
    required this.pathName,
    required this.url,
    required this.sort,
    required this.ext,
    required this.playback,
    required this.filesize,
    required this.type,
    required this.jumpUrl,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int albumId;
  String name;
  String pathName;
  String url;
  int sort;
  String ext;
  int playback;
  String filesize;
  int type;
  String jumpUrl;
  String cover;
  DateTime createdAt;
  DateTime updatedAt;

  factory FojingElement.fromJson(Map<String, dynamic> json) => FojingElement(
        id: json["id"] ?? null,
        albumId: json["album_id"] == null ? null : json["album_id"],
        name: json["name"] == null ? null : json["name"],
        pathName: json["pathName"] == null ? null : json["pathName"],
        url: json["url"] == null ? null : json["url"],
        sort: json["sort"] == null ? null : json["sort"],
        ext: json["ext"] == null ? null : json["ext"],
        playback: json["playback"] == null ? null : json["playback"],
        filesize: json["filesize"] == null ? null : json["filesize"],
        type: json["type"] == null ? null : json["type"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        cover: json["cover"] == null ? null : json["cover"],
        createdAt: json["created_at"] == null
            ? DateTime.parse('1990-1-1')
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.parse('1990-1-1')
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "album_id": albumId == null ? null : albumId,
        "name": name == null ? null : name,
        "pathName": pathName == null ? null : pathName,
        "url": url == null ? null : url,
        "sort": sort == null ? null : sort,
        "ext": ext == null ? null : ext,
        "playback": playback == null ? null : playback,
        "filesize": filesize == null ? null : filesize,
        "type": type == null ? null : type,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "cover": cover == null ? null : cover,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
