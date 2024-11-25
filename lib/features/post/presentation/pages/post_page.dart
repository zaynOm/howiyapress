import 'package:app/core/common/entities/post.dart';
import 'package:app/core/utils/unescape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostPage extends StatelessWidget {
  final Post post;
  const PostPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(children: [
            Image.network(
              post.imageUrl!,
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    unescape.convert(post.title),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HtmlWidget(
                    unescape.convert(post.content),
                    textStyle: const TextStyle(fontSize: 16),
                    // style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
