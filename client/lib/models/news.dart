class News {
  int id;
  String title;
  String subtitle;
  String text;
  String author;
  DateTime date;
  int likes;
  int numComments;
  String urlImage;
  List<int> comments;

  News({
    this.id,
    this.title,
    this.subtitle,
    this.text,
    this.author,
    this.date,
    this.likes,
    this.numComments,
    this.comments,
    this.urlImage
  });

  News.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        subtitle = json['subtitle'],
        text = json['text'],
        author = json['author'],
        likes = json['likes'],
        numComments = json['comments'],
        date = DateTime.parse(json['created_at'].toString()),
        urlImage = json['image'];
}