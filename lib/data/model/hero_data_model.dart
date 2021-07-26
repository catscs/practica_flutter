import 'package:equatable/equatable.dart';
import 'package:marvel_flutter/framework/local/database.dart';
import 'package:marvel_flutter/framework/remote/model/hero_response_data.dart';

List<HeroDataModel> heroFromHeroResponseData(
        List<HeroResponseData> heroResponseData) =>
    List<HeroDataModel>.from(heroResponseData.map((heroResponseData) =>
        HeroDataModel.fromHeroResponseData(heroResponseData)));

class HeroDataModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String path;
  final String extension;

  HeroDataModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.path,
      required this.extension});

  factory HeroDataModel.fromHeroResponseData(
          HeroResponseData heroResponseData) =>
      HeroDataModel(
        id: heroResponseData.id,
        name: heroResponseData.name,
        description: heroResponseData.description,
        path: heroResponseData.thumbnail.path,
        extension: heroResponseData.thumbnail.extension,
      );

  factory HeroDataModel.fromMovie(Movie movie) => HeroDataModel(
        id: movie.id,
        name: movie.name,
        description: movie.description,
        path: movie.path,
        extension: movie.extension,
      );

  factory HeroDataModel.empty() =>
      HeroDataModel(id: 0, name: "", description: "", path: "", extension: "");

  @override
  List<Object?> get props => [id, name, description, path, extension];
}
