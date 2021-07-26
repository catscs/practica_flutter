import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_flutter/presentation/bloc/movies/bloc.dart';
import 'package:marvel_flutter/presentation/list/widgets/hero_grid_widget.dart';
import 'package:marvel_flutter/core/widgets/circular_loading_widget.dart';

class HeroList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List the heroes"),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (_, state) {
          if (state is InitState) {
            BlocProvider.of<MoviesBloc>(context).add(GetHeroes(0, 13));
            return CircularLoadingWidget();
          } else if (state is Error) {
            return Text(state.message);
          } else if (state is Loading) {
            return CircularLoadingWidget();
          } else if (state is Movies) {
            final heroes = state.heroes;
            return HeroGridWidget(heroes: heroes);
          }
          return Container();
        },
      ),
    );
  }
}
