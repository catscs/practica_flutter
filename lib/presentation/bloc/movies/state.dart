part of 'bloc.dart';

@immutable
abstract class MoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends MoviesState {}

class Loading extends MoviesState {}

class Error extends MoviesState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Movies extends MoviesState {
  final List<HeroEntity> heroes;

  Movies({required this.heroes});

  @override
  List<Object> get props => [heroes];
}


