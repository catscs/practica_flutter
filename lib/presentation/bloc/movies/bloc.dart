import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/core/utils/constants.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_use_case.dart';

part 'event.dart';
part 'state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final HeroUseCase heroUseCase;

  MoviesBloc({required this.heroUseCase}) : super(InitState());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is GetHeroes) {
      yield Loading();
      final heroes =
          await heroUseCase(Params(offset: event.offset, limit: event.limit));
      yield* heroes.fold(_errorHandler, _successHandler);
    }
  }

  Stream<MoviesState> _successHandler(List<HeroEntity> heroes) async* {
    yield Movies(heroes: heroes);
  }

  Stream<MoviesState> _errorHandler(Failure failure) async* {
    yield Error(message: _errorMessage(failure));
  }

  String _errorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverError;
      case DBFailure:
        return dbError;
      default:
        return unexpectedError;
    }
  }
}
