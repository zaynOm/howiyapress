import 'package:app/features/domain/entities/post.dart';

class PostModel extends Post {
  PostModel({
    required super.id,
    required super.title,
    required super.content,
    required super.author,
    required super.date,
    required super.featuredMedia,
    super.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'].toString(),
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      author: json['author'].toString(),
      date: json['date'],
      featuredMedia: json['featured_media'].toString(),
      imageUrl: '',
    );
  }

  PostModel copyWith({String? imageUrl}) {
    return PostModel(
      id: id,
      title: title,
      content: content,
      author: author,
      date: date,
      featuredMedia: featuredMedia,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
