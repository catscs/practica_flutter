import 'package:dartz/dartz.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/data/data_source/data_source.dart';
import 'package:marvel_flutter/data/model/hero_data_model.dart';
import 'package:marvel_flutter/data/model/model.dart';
import 'package:marvel_flutter/framework/remote/rest_client.dart';

class HeroRemoteDataSource extends RemoteDataSource {
  final RestClient restClient;

  HeroRemoteDataSource(this.restClient);

  @override
  Future<Either<Failure, List<HeroDataModel>>> getHeroes(
      int offset, int limit) async {
    try {
      final response = await restClient.getHeroes(offset, limit);
      final heroesDataModel = heroFromHeroResponseData(response.data.results);
      return Right(heroesDataModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, HeroDataModel>> getHero(int id) async {
    try {
      final response = await restClient.getHero(id);
      final items = response.data.results;
      final heroDataModel = (items.length > 0)
          ? HeroDataModel.fromHeroResponseData(items[0])
          : HeroDataModel.empty();
      return Right(heroDataModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
