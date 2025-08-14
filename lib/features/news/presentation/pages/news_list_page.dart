import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/pages/article_detail_page.dart';
import 'package:news_app/features/news/presentation/widgets/article_card.dart';
import 'package:news_app/features/news/presentation/widgets/loading_widget.dart';

class NewsListPage extends StatelessWidget {
  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<NewsBloc>(context).add(FetchNews());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchField(context),
            const SizedBox(height: 8),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search news...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      onSubmitted: (query) {
        if (query.isNotEmpty) {
          BlocProvider.of<NewsBloc>(context).add(SearchNewsEvent(query));
        } else {
          BlocProvider.of<NewsBloc>(context).add(FetchNews());
        }
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsInitial) {
          BlocProvider.of<NewsBloc>(context).add(FetchNews());
          return const LoadingWidget();
        } else if (state is NewsLoading) {
          return const LoadingWidget();
        } else if (state is NewsLoaded) {
          return ListView.builder(
            itemCount: state.articles.length,
            itemBuilder: (context, index) {
              final article = state.articles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailPage(article: article),
                    ),
                  );
                },
                child: ArticleCard(article: article),
              );
            },
          );
        } else if (state is NewsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<NewsBloc>(context).add(FetchNews());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
