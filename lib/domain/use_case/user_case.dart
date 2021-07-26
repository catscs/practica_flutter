import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:marvel_flutter/core/error_handler/failures.dart';

abstract class UserCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}