import 'package:app/features/data/apis/posts_service.dart';
import 'package:app/features/domain/entities/post.dart';
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
  Future<List<Post>> getPosts({int page = 0}) async {
    return await postsService.getPosts(page);
  }
}
