// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeroResponseJson _$HeroResponseJsonFromJson(Map<String, dynamic> json) {
  return HeroResponseJson(
    code: json['code'] as int,
    data: Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HeroResponseJsonToJson(HeroResponseJson instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    results: (json['results'] as List<dynamic>)
        .map((e) => HeroResponseData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'results': instance.results,
    };

HeroResponseData _$HeroResponseDataFromJson(Map<String, dynamic> json) {
  return HeroResponseData(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    modified: json['modified'] as String,
    thumbnail: Thumbnail.fromJson(json['thumbnail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HeroResponseDataToJson(HeroResponseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'modified': instance.modified,
      'thumbnail': instance.thumbnail,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) {
  return Thumbnail(
    path: json['path'] as String,
    extension: json['extension'] as String,
  );
}

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'path': instance.path,
      'extension': instance.extension,
    };
