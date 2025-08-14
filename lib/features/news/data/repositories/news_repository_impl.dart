import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/datasources/news_local_data_source.dart';
import 'package:news_app/features/news/data/datasources/news_remote_data_source.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:news_app/features/news/data/models/article_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Article>>> getNews() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.getNews();
        await localDataSource.cacheArticles(remoteArticles);
        return Right(remoteArticles.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localArticles = await localDataSource.getCachedArticles();
        return Right(localArticles.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchNews(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteArticles = await remoteDataSource.searchNews(query);
        return Right(remoteArticles.map((model) => model.toEntity()).toList());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> cacheArticles(List<Article> articles) async {
    try {
      final articleModels = articles
          .map((article) => ArticleModel(
                id: article.id,
                author: article.author,
                title: article.title,
                description: article.description,
                url: article.url,
                urlToImage: article.urlToImage,
                publishedAt: article.publishedAt,
                content: article.content,
              ))
          .toList();
      await localDataSource.cacheArticles(articleModels);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getCachedArticles() async {
    try {
      final localArticles = await localDataSource.getCachedArticles();
      return Right(localArticles.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
