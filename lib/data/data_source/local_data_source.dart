import 'package:marvel_flutter/data/model/hero_data_model.dart';

abstract class LocalDataSource {
  Future<List<HeroDataModel>> getHeroes();
  Future<void> clearData();
  Future<void> saveHeroes(List<HeroDataModel> heroDataModels);
  Future<HeroDataModel> getHero(int id);
}