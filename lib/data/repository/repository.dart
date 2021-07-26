import 'package:dartz/dartz.dart';
import 'package:marvel_flutter/core/connectivity/connectivity_provider.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/data/data_source/local_data_source.dart';
import 'package:marvel_flutter/data/data_source/remote_data_source.dart';
import 'package:marvel_flutter/data/model/hero_data_model.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/entities/hero_entity.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final ConnectivityProvider connectivityProvider;

  RepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
    this.connectivityProvider,
  );

  @override
  Future<Either<Failure, List<HeroEntity>>> getHeroes(
      int offset, int limit) async {
    final isConnection = await this.connectivityProvider.isNetworkAvailable;
    if (isConnection) {
      final response = await remoteDataSource.getHeroes(offset, limit);
      final heroes = _getHeroesEntity(response);
      localDataSource.clearData();
      localDataSource.saveHeroes(response.getOrElse(() => []));
      return Right(heroes);
    }
    try {
      final response = await localDataSource.getHeroes();
      final heroes =
          response.map((e) => HeroEntity.fromHeroDataModel(e)).toList();
      return Right(heroes);
    } on DBException {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, HeroEntity>> getHero(int id) async {
    final isConnection = await this.connectivityProvider.isNetworkAvailable;
    if (isConnection) {
      final response = await remoteDataSource.getHero(id);
      final heroModel = response.getOrElse(() => HeroDataModel.empty());
      final hero = HeroEntity.fromHeroDataModel(heroModel);
      return Right(hero);
    }
    try {
      final heroModel = await localDataSource.getHero(id);
      final hero = HeroEntity.fromHeroDataModel(heroModel);
      return Right(hero);
    } on DBException {
      return Left(DBFailure());
    }
  }

  List<HeroEntity> _getHeroesEntity(
      Either<Failure, List<HeroDataModel>> response) {
    return response
        .getOrElse(() => [])
        .map((e) => HeroEntity.fromHeroDataModel(e))
        .toList();
  }
}
