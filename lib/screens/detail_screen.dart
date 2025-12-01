import 'package:flutter/material.dart';
import '../model/news_response.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepPurple.shade300,
        title: Text("Detail Berita", style: TextStyle(fontFamily: 'Domine', fontSize: 20, color: Colors.white), ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // GAMBAR BERITA
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: article.urlToImage != null
                  ? Image.network(article.urlToImage!)
                  : Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image, size: 80),
                    ),
            ),

            const SizedBox(height: 16),

            // JUDUL
            Text(
              article.title ?? "",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // AUTHOR DAN TANGGAL
            Row(
              children: [
                Text(
                  article.author ?? "Unknown",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const Spacer(),
                Text(
                  article.publishedAt != null
                      ? article.publishedAt!.substring(0, 10)
                      : "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // DESKRIPSI BERITA
            Text(
              article.description ?? "No description.",
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // KONTEN / FULL STORY
            Text(
              article.content ?? "No content available.",
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}