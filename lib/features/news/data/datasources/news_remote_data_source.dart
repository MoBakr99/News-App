import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/models/article_model.dart';
import 'package:dio/dio.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getNews();
  Future<List<ArticleModel>> searchNews(String query);
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  NewsRemoteDataSourceImpl({required this.dio, required this.networkInfo});

  @override
  Future<List<ArticleModel>> getNews() async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet connection');
    }

    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines',
      queryParameters: {
        'country': 'us',
        'apiKey':
            'a97dff74a368406491eacd6c805549f7', // Replace with your actual API key
      },
    );

    if (response.statusCode == 200) {
      return (response.data['articles'] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Future<List<ArticleModel>> searchNews(String query) async {
    if (!await networkInfo.isConnected) {
      throw Exception('No internet connection');
    }

    final response = await dio.get(
      'https://newsapi.org/v2/everything',
      queryParameters: {
        'q': query,
        'apiKey':
            'a97dff74a368406491eacd6c805549f7', // Replace with your actual API key
      },
    );

    if (response.statusCode == 200) {
      return (response.data['articles'] as List)
          .map((article) => ArticleModel.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to search news');
    }
  }
}
