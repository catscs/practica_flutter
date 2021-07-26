import 'package:marvel_flutter/framework/remote/model/hero_response_data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://gateway.marvel.com/v1/public/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("characters")
  Future<HeroResponseJson> getHeroes(
    @Query("offset") int offset,
    @Query("limit") int limit,
  );

  @GET("characters/{id}")
  Future<HeroResponseJson> getHero(
    @Path("id") int id,
  );
}
