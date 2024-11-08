import 'package:app/core/theme/app_palette.dart';
import 'package:app/features/domain/entities/post.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class NewsCard extends StatelessWidget {
  final Post post;
  const NewsCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: 200.0,
        child: Stack(
          children: [
            Image.network(
              post.imageUrl!,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppPalette.foregroundColor.withOpacity(0.9),
                ],
              )),
            ),
            Positioned(
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              child: Text(
                unescape.convert(post.title),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppPalette.textNegativeColor,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
