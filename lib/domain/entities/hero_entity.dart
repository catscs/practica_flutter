import 'package:equatable/equatable.dart';
import 'package:marvel_flutter/data/model/hero_data_model.dart';

List<HeroEntity> heroFromHeroDataModel(List<HeroDataModel> heroDataModel) =>
    List<HeroEntity>.from(
        heroDataModel.map((heroModel) => HeroEntity.fromHeroDataModel(heroModel)));

class HeroEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String path;
  final String extension;

  HeroEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.path,
      required this.extension});

  factory HeroEntity.fromHeroDataModel(HeroDataModel heroDataModel) {
    return HeroEntity(
        id: heroDataModel.id,
        name: heroDataModel.name,
        description: heroDataModel.description,
        path: heroDataModel.path,
        extension: heroDataModel.extension);
  }

  String photo(String type) => "$path/$type.$extension";

  @override
  List<Object?> get props => [id, name, description, path, extension];
}

enum Portrait {
  portrait_small,
  portrait_medium,
  portrait_xlarge,
  portrait_fantastic,
  portrait_uncanny,
  portrait_incredible
}

enum Landscape {
  landscape_small,
  landscape_medium,
  landscape_large,
  landscape_xlarge,
  landscape_amazing,
  landscape_incredible
}
