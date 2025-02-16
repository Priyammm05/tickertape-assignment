class NewsArticle {
  final String title;
  final Source source;
  final String? author;
  final String publishedAt;
  final String description;
  final String url;
  final String? urlToImage;
  final String? content;

  NewsArticle({
    required this.title,
    required this.source,
    this.author,
    required this.publishedAt,
    required this.description,
    required this.url,
    this.urlToImage,
    this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      source: Source.fromJson(json['source'] ?? {}),
      author: json['author'],
      publishedAt: json['publishedAt'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'source': source.toJson(),
      'author': author,
      'publishedAt': publishedAt,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
    };
  }
}

class Source {
  final String? id;
  final String name;

  Source({
    this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'] ?? 'Unknown Source',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
