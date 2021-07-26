import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/domain/use_case/hero_use_case.dart';
import 'package:marvel_flutter/presentation/bloc/movies/bloc.dart';
import 'package:marvel_flutter/presentation/list/widgets/hero_grid_widget.dart';
import 'package:marvel_flutter/presentation/list/widgets/hero_row_widget.dart';
import 'package:marvel_flutter/presentation/presentation.dart';
import 'package:mockito/annotations.dart';

import 'hero_list_test.mocks.dart';


@GenerateMocks([HeroUseCase])
void main() {

  late MoviesBloc sut;
  late MockHeroUseCase mockHeroUseCase;

  setUp(() {
    mockHeroUseCase = MockHeroUseCase();
    sut = MoviesBloc(heroUseCase: mockHeroUseCase);
  });

  tearDown(() {
    sut.close();
  });

  testWidgets('should appBar and be the loading', (tester) async {
    // Result
    sut.emit(Loading());
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child: HeroList())));

    // Check
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("List the heroes"), findsOneWidget);
  });

  testWidgets('should be the heroes', (tester) async {
    // Prepare
    final hero = [
      HeroEntity(
          id: 1,
          name: 'name',
          description: 'description',
          path: 'path',
          extension: 'extension')
    ];

    // Result
    sut.emit(Movies(heroes: hero));
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child: HeroList())));

    // Check
    expect(find.byType(HeroGridWidget), findsOneWidget);
    expect(find.byType(HeroRowWidget), findsOneWidget);
  });


  testWidgets('should be the error', (tester) async {
    // Result
    sut.emit(Error(message: "DB error"));
    await tester.pumpWidget(
        createWidgetForTesting(child: BlocProvider.value(value: sut, child: HeroList())));

    // Check
    expect(find.text("DB error"), findsOneWidget);
  });

}

Widget createWidgetForTesting({required Widget child}){
  return MaterialApp(
    home: child,
  );
}