part of 'bloc.dart';

@immutable
abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class Loading extends MovieState {}

class Error extends MovieState {
  final String message;

  Error({required this.message});

  @override
  List<Object> get props => [message];
}

class Movie extends MovieState {
  final HeroEntity hero;

  Movie({required this.hero});

  @override
  List<Object> get props => [hero];
}