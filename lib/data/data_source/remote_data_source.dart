import 'package:dartz/dartz.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/data/model/hero_data_model.dart';

abstract class RemoteDataSource {
  Future<Either<Failure, List<HeroDataModel>>> getHeroes(int offset, int limit);
  Future<Either<Failure, HeroDataModel>> getHero(int id);
}