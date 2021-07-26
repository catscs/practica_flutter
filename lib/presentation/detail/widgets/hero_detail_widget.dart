import 'package:flutter/material.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/presentation/detail/widgets/image_detail_widget.dart';

class HeroDetailWidget extends StatelessWidget {

  final HeroEntity hero;
  const HeroDetailWidget({required this.hero});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageDetailWidget(hero: hero),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              hero.name,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 29.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              hero.description,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
