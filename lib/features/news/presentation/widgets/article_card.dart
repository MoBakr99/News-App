import 'package:flutter/material.dart';
import 'package:news_app/features/news/domain/entities/article.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: const Color(0xFF00232B),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(25)),
              child: CachedNetworkImage(
                imageUrl: article.urlToImage!,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? 'No title',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (article.description != null)
                  Text(
                    article.description!,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (article.author != null)
                      Text(
                        article.author!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    if (article.publishedAt != null)
                      Text(
                        DateFormat('MMM d').format(article.publishedAt!),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
