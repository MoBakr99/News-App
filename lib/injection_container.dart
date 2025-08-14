// ignore_for_file: depend_on_referenced_packages

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final sl = GetIt.instance;

Future<void> init() async {
  // Features - News
  // Bloc
  sl.registerFactory(
    () => NewsBloc(
      getNews: sl(),
      searchNews: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetNews(sl()));
  sl.registerLazySingleton(() => SearchNews(sl()));

  // Repository
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(
      dio: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(box: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ArticleModelAdapter());
  final articlesBox = await Hive.openBox<ArticleModel>('articles');
  sl.registerLazySingleton(() => articlesBox);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
