import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';
import 'package:marvel_flutter/domain/use_case/hero_detail_user_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hero_detail_use_case_test.mocks.dart';


@GenerateMocks([Repository])
void main() {
  late MockRepository mockRepository;
  late HeroDetailUseCase sut;

  setUp(() {
    mockRepository = MockRepository();
    sut = HeroDetailUseCase(mockRepository);
  });

  test('should get data form repository', () async {
    // Prepare
    final hero =
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension')
    ;
    when(mockRepository.getHero(any))
        .thenAnswer((_) async => Right(hero));

    // Result
    final result = await sut(Params(id: 1));

    // Check
    expect(Right(hero), result);
    verify(mockRepository.getHero(any)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
