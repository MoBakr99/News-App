import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getNews();
  Future<Either<Failure, List<Article>>> searchNews(String query);
  Future<Either<Failure, void>> cacheArticles(List<Article> articles);
  Future<Either<Failure, List<Article>>> getCachedArticles();
}
