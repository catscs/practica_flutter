import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';
import 'package:marvel_flutter/presentation/detail/hero_detail.dart';

class HeroRowWidget extends StatelessWidget {
  final HeroEntity hero;

  HeroRowWidget({required this.hero});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => HeroDetail(id: hero.id))),
      child: CachedNetworkImage(
        imageUrl: hero.photo(describeEnum(Portrait.portrait_fantastic)),
        imageBuilder: (context, imageProvider) => Container(
          width: 150.0,
          height: 170.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: 40.0,
            height: 40.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          size: 70.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
