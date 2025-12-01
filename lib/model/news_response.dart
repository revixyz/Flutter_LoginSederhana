class Source{ // membuat class Source
  String? id; // mendeklarasikan variabel id dengan tipe data String yang bersifat nullable
  String? name; // mendeklarasikan variabel name dengan tipe data String yang bersifat nullable

  Source({ // konstruktor
    this.id, // konstruktor dengan parameter opsional
    this.name, // konstruktor dengan parameter opsional
  });

  Source.fromJson(Map<String, dynamic> data) { // mengubah map menjadi object
    id = data['id']; //'id' identifier dalam json atau key
    name = data['name']; //'name' identifier dalam json atau key
  }

  Map<String, dynamic> toJson() {  // mengubah object menjadi map
    final Map<String, dynamic> data = <String, dynamic>{}; // membuat map kosong
    data['id'] = id; // mengisi map dengan key dan value
    data['name'] = name; // mengisi map dengan key dan value
    return data; // mengembalikan data dalam bentuk map
  }
}

class Article{ // membuat class Article
  Source? source; // mendeklarasikan variabel source dengan tipe data Source yang bersifat nullable
  String? author; // mendeklarasikan variabel author dengan tipe data String yang bersifat nullable
  String? title; // mendeklarasikan variabel title dengan tipe data String yang bersifat nullable
  String? description; // mendeklarasikan variabel description dengan tipe data String yang bersifat nullable
  String? url; // mendeklarasikan variabel url dengan tipe data String yang bersifat nullable
  String? urlToImage; // mendeklarasikan variabel urlToImage dengan tipe data String yang bersifat nullable
  String? publishedAt; // mendeklarasikan variabel publishedAt dengan tipe data String yang bersifat nullable
  String? content; // mendeklarasikan variabel content dengan tipe data String yang bersifat nullable

  Article({ // konstruktor
    this.source, // konstruktor dengan parameter opsional
    this.author, // konstruktor dengan parameter opsional
    this.title, // konstruktor dengan parameter opsional
    this.description, // konstruktor dengan parameter opsional
    this.url, // konstruktor dengan parameter opsional
    this.urlToImage, // konstruktor dengan parameter opsional
    this.publishedAt, // konstruktor dengan parameter opsional
    this.content, // konstruktor dengan parameter opsional
  });

  Article.fromJson(Map<String, dynamic> data) { // mengubah map menjadi object
    source = data['source'] != null ? Source.fromJson(data['source']) : null; //'source' identifier dalam json atau key didalam API cource bertipe object(harus di tindak menjadi null)
    author = data['author']; //'author' identifier dalam json atau key
    title = data['title']; //'title' identifier dalam json atau key
    description = data['description']; //'description' identifier dalam json atau key
    url = data['url']; //'url' identifier dalam json atau key
    urlToImage = data['urlToImage']; //'urlToImage' identifier dalam json atau key
    publishedAt = data['publishedAt']; //'publishedAt' identifier dalam json atau key
    content = data['content']; //'content' identifier dalam json atau key
  }

  get imageUrl => null;

  Map<String, dynamic> toJson() { // mengubah object menjadi map
    if (source != null) { // jika source tidak null
      source!.toJson(); // mengubah object source menjadi map
    }
    final Map<String, dynamic> data = <String, dynamic>{}; // membuat map kosong
    data['author'] = author; // mengisi map dengan key dan value
    data['title'] = title; // mengisi map dengan key dan value
    data['description'] = description; // mengisi map dengan key dan value
    data['url'] = url; // mengisi map dengan key dan value
    data['urlToImage'] = urlToImage; // mengisi map dengan key dan value
    data['publishedAt'] = publishedAt; // mengisi map dengan key dan value    
    data['content'] = content; // mengisi map dengan key dan value
    return data; // mengembalikan data dalam bentuk map
  }
} 

class NewsResponse{ // membuat class NewsResponse
  String? status; // mendeklarasikan variabel status dengan tipe data String yang bersifat nullable
  int? totalResults; // mendeklarasikan variabel totalResults dengan tipe data int yang bersifat nullable
  List<Article>? articles; // mendeklarasikan variabel articles dengan tipe data List<Article> yang bersifat nullable

  NewsResponse({ // konstruktor
    this.status, // konstruktor dengan parameter opsional
    this.totalResults, // konstruktor dengan parameter opsional
    this.articles, // konstruktor dengan parameter opsional
  });

  NewsResponse.fromJson(Map<String, dynamic> data) { // mengubah map menjadi object
    status = data['status']; //'status' identifier dalam json atau key
    totalResults = data['totalResults']; //'totalResults' identifier dalam json atau key
    if (data['articles'] != null) { // jika 'articles' dalam json tidak boleh null
      articles = <Article>[]; // inisialisasi articles sebagai list kosong
      data['articles'].forEach((v) { // melakukan iterasi atau perulangan pada setiap elemen dalam 'articles'
        articles!.add(Article.fromJson(v)); // menambahkan objek Article yang dibuat dari json ke dalam list articles dengan nama v
      });
    }
  }

  get message => null;

  get urlToImage => null;

  get title => null;

  get description => null;
  Map<String, dynamic> toJson() { // mengubah object menjadi map
    final Map<String, dynamic> data = <String, dynamic>{}; // membuat map kosong
    data['status'] = status; // mengisi map dengan key dan value
    data['totalResults'] = totalResults; // mengisi map dengan key dan value
    if (articles != null) { // jika articles tidak null
      data['articles'] = articles!.map((v) => v.toJson()).toList(); // mengisi map dengan key dan value (di convert ke array menggunakan list)
    }
    return data; // mengembalikan data dalam bentuk map
  } 
}
