import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:marvel_flutter/core/connectivity/connectivity_provider.dart';
import 'package:marvel_flutter/core/connectivity/connectivity_provider_impl.dart';
import 'package:marvel_flutter/data/data_source/data_source.dart';
import 'package:marvel_flutter/data/repository/repository.dart';
import 'package:marvel_flutter/domain/repository/repository.dart';
import 'package:marvel_flutter/domain/use_case/hero_detail_user_case.dart';
import 'package:marvel_flutter/domain/use_case/hero_use_case.dart';
import 'package:marvel_flutter/framework/local/database.dart';
import 'package:marvel_flutter/framework/local/hero_local_data_source.dart';
import 'package:marvel_flutter/framework/remote/hero_remote_data_source.dart';
import 'package:marvel_flutter/framework/remote/rest_client.dart';
import 'package:marvel_flutter/presentation/bloc/movie/bloc.dart';
import 'package:marvel_flutter/presentation/bloc/movies/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => MoviesBloc(heroUseCase: sl()));
  sl.registerFactory(() => MovieBloc(heroDetailUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => HeroUseCase(sl()));
  sl.registerLazySingleton(() => HeroDetailUseCase(sl()));

  // Repository
  sl.registerLazySingleton<Repository>(() => RepositoryImpl(sl(), sl(), sl()));

  // Data Source
  sl.registerLazySingleton<RemoteDataSource>(() => HeroRemoteDataSource(sl()));
  sl.registerLazySingleton<LocalDataSource>(() => HeroLocalDataSource(sl()));

  // external
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.headers['Content-Type'] = ['application/json'];
    dio.options.queryParameters['ts'] = "1";
    dio.options.queryParameters['apikey'] = dotenv.env['API_KEY'];
    dio.options.queryParameters['hash'] = dotenv.env['HASH'];
    return dio;
  });
  sl.registerLazySingleton(() => RestClient(sl()));
  sl.registerLazySingleton(() => AppDatabase());
  sl.registerLazySingleton<ConnectivityProvider>(
      () => ConnectivityProviderImpl());
}
