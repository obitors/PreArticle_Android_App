class ways {
  String name;
  String data;
  
  ways(this.name, this.data);

  ways.fromJson(Map<String, dynamic> json) {
    name = json['title'];
    data = json['text'];
  }
}