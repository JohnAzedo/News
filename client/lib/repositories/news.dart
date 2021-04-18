import 'package:dio/dio.dart';
import 'package:news/models/news.dart';
import 'package:news/repositories/repository.dart';

class NewsRepository extends Repository{
  final String baseUrl = 'news';

  Future<List<News>> fetchAll() async {
    Response response = await dio.get("$ipAddress/$baseUrl");
    final List<News> news = [];
    for (dynamic json in response.data) {
      news.add(News.fromJson(json));
    }
    return news;
  }

  Future<News> getNews(int id) async{
    Response response = await dio.get("$ipAddress/$baseUrl/$id");
    return News.fromJson(response.data);
  }

}