class News {
  int id;
  String title;
  String subtitle;
  String text;
  String author;
  int likes;
  List<int> comments;

  News({
    this.id,
    this.title,
    this.subtitle,
    this.text,
    this.author,
    this.likes,
    this.comments
  });

  News.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        subtitle = json['subtitle'],
        text = json['text'],
        author = json['author'];
}