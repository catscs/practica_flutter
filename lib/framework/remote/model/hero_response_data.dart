import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'hero_response_data.g.dart';

HeroResponseJson heroResponseDataFromJson(String str) =>
    HeroResponseJson.fromJson(json.decode(str));

String heroResponseDataToJson(HeroResponseJson data) =>
    json.encode(data.toJson());

@JsonSerializable()
class HeroResponseJson {
  HeroResponseJson({
    required this.code,
    required this.data,
  });

  int code;
  Data data;

  factory HeroResponseJson.fromJson(Map<String, dynamic> json) =>
      HeroResponseJson(
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
      };
}

@JsonSerializable()
class Data {
  Data({
    required this.results,
  });

  List<HeroResponseData> results;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        results: List<HeroResponseData>.from(
            json["results"].map((x) => HeroResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class HeroResponseData {
  HeroResponseData({
    required this.id,
    required this.name,
    required this.description,
    required this.modified,
    required this.thumbnail,
  });

  int id;
  String name;
  String description;
  String modified;
  Thumbnail thumbnail;

  factory HeroResponseData.fromJson(Map<String, dynamic> json) =>
      HeroResponseData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        modified: json["modified"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "modified": modified,
        "thumbnail": thumbnail.toJson(),
      };
}

@JsonSerializable()
class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });

  String path;
  String extension;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
      };
}
