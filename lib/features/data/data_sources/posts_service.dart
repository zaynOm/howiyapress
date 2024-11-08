import 'package:app/core/data/remote/dio_network.dart';
import 'package:app/features/data/models/post_model.dart';
import 'package:app/features/domain/entities/paginated_posts.dart';
import 'package:dio/dio.dart';
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
    for (int i = 0; i < posts.length; i++) {
      final postId = posts[i].featuredMedia;
      final imageUrl = await getImageUrl(postId);
      posts[i] = posts[i].copyWith(imageUrl: imageUrl);
    }
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
    final response =
        await dio.get('https://howiyapress.com/wp-json/wp/v2/media/$mediaId');
    return response.data['source_url'];
  }
}
