import 'package:app/features/domain/entities/paginated_posts.dart';

class PaginatedPostsModel extends PaginatedPosts {
  PaginatedPostsModel({
    required super.posts,
    required super.currentPage,
    required super.totalPages,
  });
}
