import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/presentation/list/widgets/hero_row_widget.dart';

class HeroGridWidget extends StatelessWidget {
  final List<HeroEntity> heroes;

  HeroGridWidget({required this.heroes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 3 / 5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: heroes.length,
      itemBuilder: (BuildContext ctx, index) {
        final hero = heroes[index];
        return HeroRowWidget(hero: hero);
      },
    );
  }
}
