import 'package:app/features/home/domain/entities/post.dart';

class PaginatedPosts {
  final List<Post> posts;
  final int currentPage;
  final int totalPages;

  PaginatedPosts({
    required this.posts,
    required this.currentPage,
    required this.totalPages,
  });
}
