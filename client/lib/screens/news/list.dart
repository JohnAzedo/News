import 'package:flutter/material.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';
import 'package:news/screens/news/components/card.dart';

class ListNews extends StatefulWidget {
  @override
  _ListNewsState createState() => _ListNewsState();
}

class _ListNewsState extends State<ListNews> {
  final NewsRepository repository = NewsRepository();
  List<News> _news = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  Future<void> _getNews() async {
    return repository.fetchAll().then((news) {
      setState(() {
        this._news = news;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias'),
      ),
      body: RefreshIndicator(
        onRefresh: _getNews,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _news.length,
            itemBuilder: (BuildContext context, index) {
              News uNews = _news[index];
              return CardNews(
                news: uNews,
              );
            },
          ),
        ),
      ),
    );
  }
}
