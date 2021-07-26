import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_flutter/core/di/module.dart';
import 'package:marvel_flutter/core/platform/theme.dart';
import 'package:marvel_flutter/presentation/bloc/movie/bloc.dart';
import 'package:marvel_flutter/presentation/bloc/movies/bloc.dart';

import '../../presentation/presentation.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MoviesBloc>()),
        BlocProvider(create: (_) => sl<MovieBloc>())
      ],
      child: MaterialApp(
        title: 'Marvel',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        initialRoute: 'heroes',
        routes: {
          'heroes': (_) => HeroList(),
          'hero'  : (_) => HeroDetail(id: 0)
        },
      ),
    );
  }
}
