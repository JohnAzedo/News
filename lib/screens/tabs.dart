import 'package:flutter/material.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';

import 'news/list.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final NewsRepository repository = NewsRepository();

  Future<List<News>> _getExploreNews() async {
    return repository.fetchAll().then((news) => news);
  }

  Future<List<News>> _getFavoriteNews() async {
    return repository.fetchFavoriteNews().then((news) => news);
  }

  Future<List<News>> _getReadNews() async {
    return repository.fetchReadNews().then((news) => news);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Notícias'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.explore),
                ),
                Tab(
                    icon: Icon(Icons.favorite),
                  ),
                Tab(
                  icon: Icon(Icons.check_circle),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListNews(
                getNews: _getExploreNews,
              ),
              ListNews(
                getNews: _getFavoriteNews,
              ),
              ListNews(
                getNews: _getReadNews,
              ),
            ],
          )),
    );
  }

}
