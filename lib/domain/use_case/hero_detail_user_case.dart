

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_flutter/core/error_handler/failures.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';
import 'package:marvel_flutter/domain/use_case/user_case.dart';

class HeroDetailUseCase implements UserCase<HeroEntity, Params> {

  final Repository repository;

  HeroDetailUseCase(this.repository);

  @override
  Future<Either<Failure, HeroEntity>> call(Params params) async {
    return await repository.getHero(params.id);
  }

}

class Params extends Equatable {
  final int id;

  Params({required this.id});

  @override
  List<Object?> get props => [id];
}