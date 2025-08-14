// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:news_app/features/news/domain/usecases/get_news.dart';
import 'package:news_app/features/news/domain/usecases/search_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNews getNews;
  final SearchNews searchNews;

  NewsBloc({required this.getNews, required this.searchNews})
      : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      final result = await getNews(NoParams());
      result.fold(
        (failure) => emit(const NewsError(message: 'Failed to fetch news')),
        (articles) => emit(NewsLoaded(articles: articles)),
      );
    });

    on<SearchNewsEvent>((event, emit) async {
      emit(NewsLoading());
      final result = await searchNews(event.query);
      result.fold(
        (failure) => emit(const NewsError(message: 'Failed to search news')),
        (articles) => emit(NewsLoaded(articles: articles)),
      );
    });
  }
}
