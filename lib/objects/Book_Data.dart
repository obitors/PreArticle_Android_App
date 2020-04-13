class Book {
  final String name;
  final String author;
  final String file;
  final String image;
  final List category;
  final List collection;

  Book({this.name, this.author, this.file, this.image, this.category, this.collection});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'] as String,
      author: json['author'] as String,
      file: json['file'] as String,
      image: json['image'] as String,
      category: json['category'],
      collection: json['collection'],
    );
  }
}