import 'package:marvel_flutter/data/data_source/data_source.dart';
import 'package:marvel_flutter/data/model/hero_data_model.dart';

import 'database.dart';

class HeroLocalDataSource extends LocalDataSource {
  final AppDatabase appDatabase;

  HeroLocalDataSource(this.appDatabase);

  @override
  Future<void> clearData() async {
    await this.appDatabase.movieDao.clearData();
  }

  @override
  Future<List<HeroDataModel>> getHeroes() async {
    final response = await this.appDatabase.movieDao.getAllHeroes()
      ..sort((a, b) => b.id.compareTo(a.id));
    return response.map((e) => HeroDataModel.fromMovie(e)).toList();
  }

  @override
  Future<void> saveHeroes(List<HeroDataModel> heroDataModels) async {
    final movies = heroDataModels
        .map((e) => Movie(
            id: e.id,
            name: e.name,
            description: e.description,
            extension: e.extension,
            path: e.path))
        .toList();
    await this.appDatabase.movieDao.insertAllHeroes(movies);
  }

  @override
  Future<HeroDataModel> getHero(int id) async {
    final movie = await this.appDatabase.movieDao.getHero(id);
    return HeroDataModel.fromMovie(movie);
  }
}
