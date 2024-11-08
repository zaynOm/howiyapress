import 'package:app/core/data/remote/dio_network.dart';
import 'package:app/features/data/models/post_model.dart';
import 'package:app/features/domain/entities/paginated_posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postsServiceImplProvider = Provider<PostsService>((ref) {
  final dio = ref.watch(dioNetworkProvider);
  return PostsServiceImpl(dio);
});

abstract interface class PostsService {
  Future<PaginatedPosts> getPosts(int page);
  Future<String> getImageUrl(String mediaId);
}

class PostsServiceImpl implements PostsService {
  final Dio dio;

  PostsServiceImpl(this.dio);
  @override
  Future<PaginatedPosts> getPosts(int page) async {
    debugPrint('****************************GetPosts was called: $page');
    final response = await dio.get('/posts', queryParameters: {'page': page});

    List<PostModel> posts =
        (response.data as List).map((e) => PostModel.fromJson(e)).toList();

    final totalPages = response.headers['x-wp-totalpages']?.first;

    Stopwatch stopwatch = Stopwatch()..start();

    debugPrint('****************************Before for loop');
    // Fetch and update each post with its image URL

    // Fetch and update each post with its image URL in parallel
    final updatedPosts = await Future.wait(posts.map((post) async {
      final imageUrl = await getImageUrl(post.featuredMedia);
      return post.copyWith(imageUrl: imageUrl);
    }));

// Replace the original list with the updated one
    posts = updatedPosts;
    debugPrint('****************************After for loop');

    stopwatch.stop();
    debugPrint(
        '****************************GetPosts took: ${stopwatch.elapsedMilliseconds} ms');

    return PaginatedPosts(
        posts: posts,
        currentPage: page,
        totalPages: int.parse(totalPages.toString()));
  }

  @override
  Future<String> getImageUrl(String mediaId) async {
    final response = await dio.get('/media/$mediaId');
    return response.data['source_url'];
  }
}
