import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/model/news_response.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<NewsResponse> _listArticles;

   @override
   void initState() {
    super.initState();
    _listArticles = getNews();
  }

 Future<NewsResponse> getNews() async{ //mengambil endpoint top headline
    var url = "https://newsapi.org/v2/";
    var endpoint = "top-headlines";
    var apiKey = "0f217dfd60c84001a1857f393dcbe32d";
    var q = "Jokowi";

    var uri = Uri.parse("$url$endpoint?q=$q&apiKey=$apiKey");
    var response = await http.get(uri); //respon sudah berbentuk json

    if(response.statusCode == 200){
      var newsresponse = NewsResponse.fromJson(jsonDecode(response.body));
      var status = newsresponse.status; //mengambil dari class response
      var totalResults = newsresponse.totalResults;

      debugPrint("Status = $status, total Result = $totalResults");
      return newsresponse;
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Headlines"),
        centerTitle: true,
      ),

      body: FutureBuilder<NewsResponse>(
        future: _listArticles, // fetch API
        builder: (context, snapshot) {
          
          // Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // Tidak ada data
          if (!snapshot.hasData || snapshot.data!.articles == null) {
            return const Center(child: Text("Tidak ada data"));
          }

          final articles = snapshot.data!.articles!;

          // List tampilan berita
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];

              return Card(
                margin: const EdgeInsets.all(12),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: InkWell(
                  onTap: () {},

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      // Gambar Berita
                      if (article.urlToImage != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            article.urlToImage!,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),

                      // Konten Teks
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            // Nama Source
                            Text(
                              article.source?.name ?? "Unknown Source",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Judul Berita
                            Text(
                              article.title ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Deskripsi singkat
                            Text(
                              article.description ?? "No Description",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 10),

                            // Tanggal publish
                            Text(
                              article.publishedAt ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

//assincronus -> bisa lebih dari 1 proses dalam 1 waktu --> ketika menggambil data sebelum get news (menunggu data itu sebelum data itu diambil)
//sincronus ->