class Post {
  final String id;
  final String title;
  final String content;
  final String date;
  final String author;
  final String featuredMedia;
  final String? imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
    required this.featuredMedia,
    this.imageUrl,
  });
}
