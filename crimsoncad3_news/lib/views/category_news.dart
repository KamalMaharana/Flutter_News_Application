import 'package:crimsoncad3_news/helper/news.dart';
import 'package:crimsoncad3_news/models/article_model.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Category extends StatefulWidget {
  final String category;
  Category({@required this.category});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Crimson',
              style: TextStyle(
                color: Colors.redAccent[400],
              ),
            ),
            Text('News')
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          ),
        ],
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.only(top: 16.0),
                      //height: 500.0,
                      // Either Use Height for this ListView Container or
                      // Set Physics to ClampingScrollPhysics()
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: articles.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return BlockTile(
                              imageURL: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
