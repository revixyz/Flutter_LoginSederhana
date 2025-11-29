import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article_model.dart';

class NewsService { 
  final String apiKey = "0f217dfd60c84001a1857f393dcbe32d"; 

  Future<List<Article>> getTopHeadlines() async { 
    final url = Uri.parse(
      "https://newsapi.org/v2/everything?q=weather&apiKey=$apiKey", 
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List articles = jsonData['articles'];

      return articles
          .map((json) => Article.fromJson(json))
          .toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }
}
