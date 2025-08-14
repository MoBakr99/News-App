import 'package:news_app/core/errors/exceptions.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:hive/hive.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheArticles(List<ArticleModel> articles);
  Future<List<ArticleModel>> getCachedArticles();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {
  final Box<ArticleModel> box;

  NewsLocalDataSourceImpl({required this.box});

  @override
  Future<void> cacheArticles(List<ArticleModel> articles) async {
    try {
      await box.clear();
      await box.addAll(articles);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ArticleModel>> getCachedArticles() async {
    try {
      return box.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }
}
