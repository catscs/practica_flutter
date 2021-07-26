
part of 'bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class GetHeroes extends MoviesEvent {
  final int offset;
  final int limit;

  GetHeroes(this.offset, this.limit);

  @override
  List<Object> get props => [offset, limit];

}
