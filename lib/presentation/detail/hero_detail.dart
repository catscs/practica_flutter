import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_flutter/core/widgets/circular_loading_widget.dart';
import 'package:marvel_flutter/core/widgets/linear_loading_widget.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/presentation/bloc/movie/bloc.dart';
import 'package:marvel_flutter/presentation/detail/widgets/hero_detail_widget.dart';

class HeroDetail extends StatefulWidget {
  final int id;

  const HeroDetail({required this.id});

  @override
  _HeroDetailState createState() => _HeroDetailState();
}

class _HeroDetailState extends State<HeroDetail> {
  HeroEntity? _heroEntity;

  @override
  void initState() {
    super.initState();
    _loadHero();
  }

  _loadHero() {
    BlocProvider.of<MovieBloc>(context).add(GetHero(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _heroEntity != null
            ? Text(_heroEntity!.name)
            : LinearLoadingWidget(),
      ),
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (_, state) {
          if (state is Error) {
            return Text(state.message);
          } else if (state is Loading) {
            return CircularLoadingWidget();
          } else if (state is Movie) {
            final hero = state.hero;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              setState(() {
                _heroEntity = hero;
              });
            });
            return HeroDetailWidget(hero: hero);
          }
          return Container();
        },
      ),
    );
  }
}
