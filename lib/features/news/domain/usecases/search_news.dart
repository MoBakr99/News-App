import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class SearchNews implements UseCase<List<Article>, String> {
  final NewsRepository repository;

  SearchNews(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(String query) async {
    return await repository.searchNews(query);
  }
}
