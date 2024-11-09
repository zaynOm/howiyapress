import 'package:app/features/home/domain/entities/paginated_posts.dart';

abstract class PostRepo {
  Future<PaginatedPosts> getPosts(int page);
}
