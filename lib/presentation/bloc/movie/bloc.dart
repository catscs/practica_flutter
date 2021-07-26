import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/core/utils/constants.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_detail_user_case.dart';

part 'event.dart';
part 'state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final HeroDetailUseCase heroDetailUseCase;

  MovieBloc({required this.heroDetailUseCase})
      : super(Loading());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is GetHero) {
      yield Loading();
      final heroes =
      await heroDetailUseCase(Params(id: event.id));
      yield* heroes.fold(_errorHandler, _successHandler);
    }
  }

  Stream<MovieState> _successHandler(HeroEntity hero) async* {
    yield Movie(hero: hero);
  }

  Stream<MovieState> _errorHandler(Failure failure) async* {
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

