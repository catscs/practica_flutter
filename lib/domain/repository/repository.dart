import 'package:dartz/dartz.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';

abstract class Repository {
  Future<Either<Failure, List<HeroEntity>>> getHeroes(int offset, int limit);
  Future<Either<Failure, HeroEntity>> getHero(int id);
}