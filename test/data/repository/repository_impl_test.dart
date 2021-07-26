import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/core/connectivity/connectivity_provider.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/data/data_source/data_source.dart';
import 'package:marvel_flutter/data/model/model.dart';
import 'package:marvel_flutter/data/repository/repository.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDataSource, ConnectivityProvider])
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockConnectivityProvider mockConnectivityProvider;
  late RepositoryImpl sut;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockConnectivityProvider = MockConnectivityProvider();
    sut = RepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockConnectivityProvider,
    );
  });

  group('Get Heroes', () {
    test(
        'when hasInternet is true then get heroes from remote and save data local',
        () async {
      // Prepare
      final heroes = [
        HeroDataModel(
            id: 1,
            name: 'name',
            description: 'description',
            path: 'path',
            extension: 'extension')
      ];
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHeroes(any, any))
          .thenAnswer((_) async => Right(heroes));
      when(mockLocalDataSource.clearData())
          .thenAnswer((_) async => Future.value());
      when(mockLocalDataSource.saveHeroes(heroes))
          .thenAnswer((_) async => Future.value());

      // Result
      await sut.getHeroes(0, 0);

      // Check
      verifyInOrder([
        mockRemoteDataSource.getHeroes(any, any),
        mockLocalDataSource.clearData(),
        mockLocalDataSource.saveHeroes(heroes)
      ]);
    });

    test('when hasInternet is false then get heroes from local', () async {
      // Prepare
      final heroesModel = [
        HeroDataModel(
            id: 1,
            name: 'name',
            description: 'description',
            path: 'path',
            extension: 'extension')
      ];
      final heroes = [
        HeroEntity(
            id: 1,
            name: 'name',
            description: 'description',
            path: 'path',
            extension: 'extension')
      ];
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => false);
      when(mockLocalDataSource.getHeroes())
          .thenAnswer((_) async => Future.value(heroesModel));

      // Result
      final result = await sut.getHeroes(0, 0);

      // Check
      verifyZeroInteractions(mockRemoteDataSource);
      verify(mockLocalDataSource.getHeroes()).called(1);
      expect(heroes, result.getOrElse(() => []));
    });

    test('when error db then get heroes from local', () async {
      // Prepare
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => false);
      when(mockLocalDataSource.getHeroes()).thenThrow(DBException());

      // Result
      final result = await sut.getHeroes(0, 0);

      // Check
      assert(result.isLeft());
    });
  });

  group('Get Hero', () {
    test('when hasInternet is true then get from remote', () async {
      // Prepare
      final hero = HeroEntity(
        id: 0,
        name: 'name',
        description: 'description',
        path: 'path',
        extension: 'extension',
      );
      final heroModel = HeroDataModel(
        id: 0,
        name: 'name',
        description: 'description',
        path: 'path',
        extension: 'extension',
      );
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => true);
      when(mockRemoteDataSource.getHero(any))
          .thenAnswer((_) async => Right(heroModel));

      // Result
      final result = await sut.getHero(0);

      // Check
      verify(mockRemoteDataSource.getHero(any));
      expect(Right(hero), result);
    });

    test('when hasInternet is false then get from local', () async {
      // Prepare
      final hero = HeroEntity(
        id: 0,
        name: 'name',
        description: 'description',
        path: 'path',
        extension: 'extension',
      );
      final heroModel = HeroDataModel(
        id: 0,
        name: 'name',
        description: 'description',
        path: 'path',
        extension: 'extension',
      );
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => false);
      when(mockLocalDataSource.getHero(any))
          .thenAnswer((_) async => heroModel);

      // Result
      final result = await sut.getHero(0);

      // Check
      verify(mockLocalDataSource.getHero(any));
      verifyZeroInteractions(mockRemoteDataSource);
      expect(Right(hero), result);
    });

    test('when error db then get hero from local', () async {
      // Prepare
      when(mockConnectivityProvider.isNetworkAvailable)
          .thenAnswer((_) async => false);
      when(mockLocalDataSource.getHero(any)).thenThrow(DBException());

      // Result
      final result = await sut.getHero(0);

      // Check
      assert(result.isLeft());
    });
  });
}
