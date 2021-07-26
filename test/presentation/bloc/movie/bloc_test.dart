import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/core/utils/constants.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_detail_user_case.dart';
import 'package:marvel_flutter/presentation/bloc/movie/bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'bloc_test.mocks.dart';


@GenerateMocks([HeroDetailUseCase])
void main() {
  late MockHeroDetailUseCase mockHeroDetailUseCase;
  late MovieBloc sut;

  setUp(() {
    mockHeroDetailUseCase = MockHeroDetailUseCase();
    sut = MovieBloc(heroDetailUseCase: mockHeroDetailUseCase);
  });

  tearDown(() {
    sut.close();
  });

  test('initial should be InitialState', () {
    // Check
    expect(sut.state, Loading());
  });

  test('should get data use case call event heroes', () async {
    // Prepare
    final hero =
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension');

    when(mockHeroDetailUseCase(any)).thenAnswer((_) async => Right(hero));

    // Result
    sut.add(GetHero(0));
    await untilCalled(mockHeroDetailUseCase(any));

    // Check
    verify(mockHeroDetailUseCase(any));
  });


  test('Should emit [Loading, Movie]', () async {
    // Prepare
    final hero =HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension');

    when(mockHeroDetailUseCase(any)).thenAnswer((realInvocation) async => Right(hero));

    // Result
    sut.add(GetHero(0));

    // Check
    final expected = [Loading(), Movie(hero: hero)];
    expectLater(sut.stream, emitsInOrder(expected));

  });

  test('Should emit [Loading, Error]', () async {
    // Prepare
    when(mockHeroDetailUseCase(any)).thenAnswer((realInvocation) async => Left(DBFailure()));

    // Result
    sut.add(GetHero(0));

    // Check
    final expected = [Loading(), Error(message: dbError)];
    expectLater(sut.stream, emitsInOrder(expected));

  });
}