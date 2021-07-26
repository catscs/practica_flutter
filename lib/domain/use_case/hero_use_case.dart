import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_flutter/core/error_handler/failures.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';
import 'package:marvel_flutter/domain/use_case/user_case.dart';

class HeroUseCase implements UserCase<List<HeroEntity>, Params> {

  final Repository repository;

  HeroUseCase(this.repository);

  @override
  Future<Either<Failure, List<HeroEntity>>> call(Params params) async {
    return await repository.getHeroes(params.offset, params.limit);
  }
}

class Params extends Equatable {
  final int offset;
  final int limit;

  Params({required this.offset, required this.limit});

  @override
  List<Object?> get props => [offset, limit];
}