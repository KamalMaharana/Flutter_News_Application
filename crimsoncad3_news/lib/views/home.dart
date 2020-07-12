//import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crimsoncad3_news/helper/data.dart';
import 'package:crimsoncad3_news/helper/news.dart';
import 'package:crimsoncad3_news/models/article_model.dart';
import 'package:crimsoncad3_news/models/category_model.dart';
import 'package:crimsoncad3_news/views/article_view.dart';
import 'package:crimsoncad3_news/views/category_news.dart';
import 'package:flutter/material.dart';

//import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    /// Categories
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 70.0,
                        child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              categoryName: categories[index].categoryName,
                            );
                          },
                        )),

                    ///Blog
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

// CategoryTile Class
// This class produces SINGLE TILE/BLOCK Category by fetching Categories from a LIST of CategoryModel.
// This List of CategoryModel objects is formed in data.dart
// It consists of the imageURl and categoryName
class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Category(
                      category: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 130.0,
                  height: 70.0,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 130.0,
              height: 70.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Fetched News Tile
// This Class produces single TILE/BLOCK of NEWS in the home page.
// On Tapping any of the news it'll open a webview of that news, this webview will open up that news link provided by the NEWS API
class BlockTile extends StatelessWidget {
  final String imageURL, title, desc, url;
  BlockTile(
      {@required this.imageURL,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(postUrl: this.url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageURL)),
            SizedBox(
              height: 8.0,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17.0,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.white, fontSize: 12.0),
            ),
            Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
