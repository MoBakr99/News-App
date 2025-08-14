import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? 'No title'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              article.title ?? 'No title',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (article.author != null)
                  Text(
                    'By ${article.author}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                const Spacer(),
                if (article.publishedAt != null)
                  Text(
                    DateFormat('MMM d, y').format(article.publishedAt!),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              article.description ?? 'No description',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              article.content ?? 'No content',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            if (article.url != null)
              ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(article.url!);
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const Text('Read full article'),
              ),
          ],
        ),
      ),
    );
  }
}
