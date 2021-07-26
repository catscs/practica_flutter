import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';
import 'package:marvel_flutter/domain/use_case/hero_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hero_use_case_test.mocks.dart';

@GenerateMocks([Repository])
void main() {
  late MockRepository mockRepository;
  late HeroUseCase sut;

  setUp(() {
    mockRepository = MockRepository();
    sut = HeroUseCase(mockRepository);
  });

  test('should get data form repository', () async {
    // Prepare
    final hero = [
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension')
    ];
    when(mockRepository.getHeroes(any, any))
        .thenAnswer((_) async => Right(hero));

    // Result
    final result = await sut(Params(offset: 0, limit: 0));

    // Check
    expect(Right(hero), result);
    verify(mockRepository.getHeroes(any, any)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
