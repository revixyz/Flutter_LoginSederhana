import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/model/news_response.dart';

class NewsScreens extends StatefulWidget {
  const NewsScreens({super.key});

  @override
  State<NewsScreens> createState() => _NewsScreensState();
}

class _NewsScreensState extends State<NewsScreens> {
  late Future<List<Article>?> _listArticles;

  @override
  void initState() {
    super.initState();
    _listArticles = getNews();
  }

  Future<List<Article>?> getNews() async {
    var endpoint = "everything";
    var apiKey = "0f217dfd60c84001a1857f393dcbe32d";
    var query = "crime";

    try {
      var uri = Uri.parse(
        "https://newsapi.org/v2/$endpoint?q=$query&apiKey=$apiKey",
      );
      var response = await http.get(uri);
      debugPrint("Response body: ${response.body}");
      var newsresponse = NewsResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        var status = newsresponse.status;
        var totalResults = newsresponse.totalResults;

        debugPrint("Status: $status, Total Results: $totalResults");
        return newsresponse.articles;
      } else {
        var message = newsresponse.message;
        throw Exception(message);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Widget _buildListNews(
    BuildContext context,
    AsyncSnapshot<List<Article>?> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No news articles found.'));
    } else {
      var articles = snapshot.data!;
      return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          var article = articles[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 100,
                        height: 100,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          size: 25,
                        ),
                      ),
                    )
                  : Container(
                      width: 100,
                      height: 100,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        size: 25,
                      ),
                    ),
              title: Text(article.title ?? 'No Title'),
              subtitle: Text(article.description ?? 'No Description'),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: FutureBuilder(future: _listArticles, builder: _buildListNews),
      appBar: AppBar(
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text('News', style: TextStyle(fontFamily: 'Domine', fontSize: 20, color: Colors.white),),
        centerTitle: true,
          ),
      body: FutureBuilder<List<Article>?>(future: _listArticles, builder: _buildListNews),
    );
  }
}