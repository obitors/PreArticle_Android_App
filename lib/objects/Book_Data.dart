class Book {
  final String name;
  final String author;
  final String fileurl;
  final String imageurl;
  final List category;
  final List collection;
  final int pages;

  Book({this.name, this.author, this.fileurl, this.imageurl, this.category, this.collection, this.pages});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      name: json['name'] as String,
      fileurl: json['file'] as String,
      imageurl: json['image'] as String,
      collection: json['collection'],
      author: json['author'] as String,
      pages: json['pages'],
      category: json['category'],
    );
  }
}