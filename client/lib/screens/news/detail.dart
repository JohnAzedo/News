import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/components/progress.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/news.dart';

class DetailNews extends StatefulWidget {
  final int _newsId;

  DetailNews(this._newsId);

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  final NewsRepository repository = NewsRepository();
  News _news;

  @override
  void initState() {
    super.initState();
  }

  Future<News> _getNews() async {
    return repository.getNews(widget._newsId).then((news) {
      return news;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
        actions: [Icon(Icons.favorite_border_outlined)],
      ),
      body: FutureBuilder<News>(
        future: _getNews(),
        builder: (context, snapshot) {
          final News news = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              this._news = news;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        _news.title,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Text(
                          _news.subtitle,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _news.author,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 0.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.comment_outlined),
                                      Text(_news.numComments.toString()),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 0.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.favorite_border_outlined),
                                      Text(_news.likes.toString())
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 0.0,
                        ),
                        child: Text(
                          _news.text,
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    ],
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
