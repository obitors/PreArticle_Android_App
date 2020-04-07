class Data {
  final String name;
  final String data;
  final String readTime;
  final String speechTime;
  final String words;
  final String characters;

  Data({this.name, this.data, this.readTime, this.speechTime, this.words, this.characters});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'] as String,
      data: json['data'] as String,
      readTime: json['readTime'] as String,
      speechTime: json['speechTime'] as String,
      words: json['words'],
      characters: json['characters'],
    );
  }
}