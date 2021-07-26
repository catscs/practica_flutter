import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';

class ImageDetailWidget extends StatelessWidget {
  final HeroEntity hero;

  const ImageDetailWidget({required this.hero});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470.0,
      child: CachedNetworkImage(
        imageUrl: hero.photo(describeEnum(Landscape.landscape_incredible)),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
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
