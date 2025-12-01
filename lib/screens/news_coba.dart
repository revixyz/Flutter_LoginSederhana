import 'package:flutter/material.dart';
import '../model/news_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart'; // ⬅ tambahkan ini

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>?> _articles;

  @override
  void initState() {
    super.initState();
    _articles = getNews();
  }

  Future<List<Article>?> getNews() async {
    const baseUrl = "newsapi.org";
    const endpoint = "/v2/top-headlines";
    const apiKey = "57fc2a0496804204bd66b2eb42c36509";

    var uri = Uri.https(baseUrl, endpoint, {'country': 'us', 'apiKey': apiKey});

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final result = NewsResponse.fromJson(json);
        return result.articles;
      } else {
        throw Exception("Server error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Gagal ambil data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: FutureBuilder<List<Article>?>(
        future: _articles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final articles = snapshot.data;
          if (articles == null || articles.isEmpty) {
            return const Center(child: Text('No articles available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final a = articles[index];

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(article: a),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // IMAGE
                        Container(
                          width: 100,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: a.urlToImage != null
                                ? Image.network(
                                    a.urlToImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.image, size: 40),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                a.title ?? "-",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                a.description ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    a.author ?? "Unknown",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    a.publishedAt != null
                                        ? a.publishedAt!.substring(0, 10)
                                        : "",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}