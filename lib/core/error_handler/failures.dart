import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  Failure([List prop = const <dynamic>[]]): properties = prop;

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends Failure {}

class DBFailure extends Failure {}