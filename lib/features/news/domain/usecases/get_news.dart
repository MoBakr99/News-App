import 'package:news_app/core/errors/failures.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:dartz/dartz.dart';

class GetNews implements UseCase<List<Article>, NoParams> {
  final NewsRepository repository;

  GetNews(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await repository.getNews();
  }
}
