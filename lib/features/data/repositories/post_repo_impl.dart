import 'package:app/features/data/data_sources/posts_service.dart';
import 'package:app/features/domain/entities/paginated_posts.dart';
import 'package:app/features/domain/repositories/post_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postRepoImplProvider = Provider<PostRepo>((ref) {
  final postsService = ref.watch(postsServiceImplProvider);
  return PostRepoImpl(postsService);
});

class PostRepoImpl extends PostRepo {
  final PostsService postsService;

  PostRepoImpl(this.postsService);

  @override
  Future<PaginatedPosts> getPosts(int page) async {
    return await postsService.getPosts(page);
  }
}
