import 'dart:convert';

import 'package:crimsoncad3_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&apiKey=8951d6f0c6fc412cb8eb7272398d5390";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=8951d6f0c6fc412cb8eb7272398d5390";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = new ArticleModel(
              title: element['title'],
              description: element['description'],
              author: element['author'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);

          news.add(articleModel);
        }
      });
    }
  }
}
