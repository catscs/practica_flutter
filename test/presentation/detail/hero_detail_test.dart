import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/core/error_handler/error_handler.dart';
import 'package:marvel_flutter/core/utils/constants.dart';
import 'package:marvel_flutter/core/widgets/circular_loading_widget.dart';
import 'package:marvel_flutter/core/widgets/linear_loading_widget.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_detail_user_case.dart';
import 'package:marvel_flutter/presentation/bloc/movie/bloc.dart';
import 'package:marvel_flutter/presentation/detail/hero_detail.dart';
import 'package:marvel_flutter/presentation/detail/widgets/hero_detail_widget.dart';
import 'package:marvel_flutter/presentation/detail/widgets/image_detail_widget.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hero_detail_test.mocks.dart';

@GenerateMocks([HeroDetailUseCase])
void main() {

  late MovieBloc sut;
  late MockHeroDetailUseCase mockHeroDetailUseCase;
  late HeroEntity hero;

  setUp(() {
      mockHeroDetailUseCase = MockHeroDetailUseCase();
      sut = MovieBloc(heroDetailUseCase: mockHeroDetailUseCase);

      hero = HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension');
  });

  tearDown(() {
    sut.close();
  });

  testWidgets('should be the hero', (tester) async {
    // Prepare
    when(mockHeroDetailUseCase(any)).thenAnswer((_) async => Right(hero));

    // Result
    sut.emit(Movie(hero: hero));
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child: HeroDetail(id: 1))));

    // Check
    expect(find.byType(HeroDetailWidget), findsOneWidget);
    expect(find.byType(ImageDetailWidget), findsOneWidget);
    expect(find.byType(LinearLoadingWidget), findsOneWidget);
    expectLater(find.text("name"), findsOneWidget);
  });

  testWidgets('should be the error', (tester) async {
    // Prepare
    when(mockHeroDetailUseCase(any)).thenAnswer((_) async => Left(DBFailure()));

    // Result
    sut.emit(Error(message: dbError));
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child:  HeroDetail(id: 1))));

    // Check
    expect(find.text(dbError), findsOneWidget);
  });

  testWidgets('should be the loading', (tester) async {
    // Prepare
    when(mockHeroDetailUseCase(any)).thenAnswer((_) async => Right(hero));

    // Result
    sut.emit(Loading());
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child:  HeroDetail(id: 1))));

    // Check
    expect(find.byType(CircularLoadingWidget), findsOneWidget);
  });
}

Widget createWidgetForTesting({required Widget child}){
  return MaterialApp(
    home: child,
  );
}