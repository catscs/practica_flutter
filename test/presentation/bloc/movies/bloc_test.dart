import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/core/utils/constants.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_use_case.dart';
import 'package:marvel_flutter/presentation/bloc/movies/bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([HeroUseCase])
void main() {
  late MockHeroUseCase mockHeroUseCase;
  late MoviesBloc sut;

  setUp(() {
    mockHeroUseCase = MockHeroUseCase();
    sut = MoviesBloc(heroUseCase: mockHeroUseCase);
  });

  tearDown(() {
    sut.close();
  });

  test('initial should be InitialState', () {
    // Check
    expect(sut.state, InitState());
  });

  test('should get data use case call event heroes', () async {
    // Prepare
    final heroes = [
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension')
    ];
    when(mockHeroUseCase(any)).thenAnswer((_) async => Right(heroes));

    // Result
    sut.add(GetHeroes(0, 0));
    await untilCalled(mockHeroUseCase(any));

    // Check
    verify(mockHeroUseCase(any));
  });


  test('Should emit [Loading, Movie]', () async {
    // Prepare
    final heroes = [
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension')
    ];
    when(mockHeroUseCase(any)).thenAnswer((realInvocation) async => Right(heroes));

    // Result
    sut.add(GetHeroes(0, 0));

    // Check
    final expected = [Loading(), Movies(heroes: heroes)];
    expectLater(sut.stream, emitsInOrder(expected));

  });

  test('Should emit [Loading, Error]', () async {
    // Prepare
    when(mockHeroUseCase(any)).thenAnswer((realInvocation) async => Left(DBFailure()));

    // Result
    sut.add(GetHeroes(0, 0));

    // Check
    final expected = [Loading(), Error(message: dbError)];
    expectLater(sut.stream, emitsInOrder(expected));

  });
}
