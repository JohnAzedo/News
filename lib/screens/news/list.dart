import 'package:flutter/material.dart';
import 'package:news/components/progress.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';
import 'package:news/screens/news/components/newsCard.dart';
import 'package:news/screens/news/detail.dart';

class ListNews extends StatefulWidget {
  final Function getNews;

  ListNews({@required this.getNews});

  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  final NewsRepository repository = NewsRepository();
  List<News> _news = [];

  Future<void> _markAsRead(int newsID) async{
    return repository.markAsRead(newsID).then((value) => null);
  }

  void _navigateToDetail(BuildContext context, int newsID) {
    _markAsRead(newsID);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailNews(newsID),
      ),
    );
  }

  Future<void> onRefresh() async{
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: FutureBuilder(
        future: widget.getNews(),
        builder: (context, snapshot) {
          _news = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text("No connection");
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: _news.length,
                    itemBuilder: (BuildContext context, index) {
                      News uNews = _news[index];
                      return CardNews(
                        news: uNews,
                        onTap: () => _navigateToDetail(context, uNews.id),
                      );
                    },
                  ),
                ),
              );
              break;
          }
          return Text('Unknown Error');
        },
      ),
    );
  }
}
