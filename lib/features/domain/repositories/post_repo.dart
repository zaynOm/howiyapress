import 'package:app/features/domain/entities/post.dart';

abstract class PostRepo {
  Future<List<Post>> getPosts({int page});
}
