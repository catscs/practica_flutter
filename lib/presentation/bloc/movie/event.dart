part of 'bloc.dart';

@immutable
abstract class MovieEvent extends Equatable {}

class GetHero extends MovieEvent {
  final int id;

  GetHero(this.id);

  @override
  List<Object> get props => [id];

}