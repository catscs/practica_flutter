import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_flutter/domain/entities/entities.dart';

void main() {
  late HeroEntity heroEntity;

  setUp(() {
    heroEntity = HeroEntity(
        id: 0,
        name: 'name',
        description: 'description',
        path: 'http://google.es',
        extension: 'jpg');
  });

  test('be able to check the type of photo portraitType', () {
    // Prepare
    final small = heroEntity.photo(describeEnum(Portrait.portrait_small));
    final medium = heroEntity.photo(describeEnum(Portrait.portrait_medium));
    final xlarge = heroEntity.photo(describeEnum(Portrait.portrait_xlarge));
    final fantastic = heroEntity.photo(describeEnum(Portrait.portrait_fantastic));
    final uncanny = heroEntity.photo(describeEnum(Portrait.portrait_uncanny));
    final incredible = heroEntity.photo(describeEnum(Portrait.portrait_incredible));

    // Check
    expect("http://google.es/portrait_small.jpg", small);
    expect("http://google.es/portrait_medium.jpg", medium);
    expect("http://google.es/portrait_xlarge.jpg", xlarge);
    expect("http://google.es/portrait_fantastic.jpg", fantastic);
    expect("http://google.es/portrait_uncanny.jpg", uncanny);
    expect("http://google.es/portrait_incredible.jpg", incredible);
  });

  test('be able to check the type of photo landscape', () {
    // Prepare
    final small = heroEntity.photo(describeEnum(Landscape.landscape_small));
    final medium = heroEntity.photo(describeEnum(Landscape.landscape_medium));
    final large = heroEntity.photo(describeEnum(Landscape.landscape_large));
    final xlarge = heroEntity.photo(describeEnum(Landscape.landscape_xlarge));
    final amazing = heroEntity.photo(describeEnum(Landscape.landscape_amazing));
    final incredible = heroEntity.photo(describeEnum(Landscape.landscape_incredible));

    // Check
    expect("http://google.es/landscape_small.jpg", small);
    expect("http://google.es/landscape_medium.jpg", medium);
    expect("http://google.es/landscape_large.jpg", large);
    expect("http://google.es/landscape_xlarge.jpg", xlarge);
    expect("http://google.es/landscape_amazing.jpg", amazing);
    expect("http://google.es/landscape_incredible.jpg", incredible);
  });
}
