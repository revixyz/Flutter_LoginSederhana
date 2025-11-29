import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';

class Berita extends StatefulWidget {
  const Berita({super.key});

  @override
  State<Berita> createState() => _BeritaState();
}

class _BeritaState extends State<Berita> {
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
        title: const Text('Berita', style: TextStyle(fontFamily: 'Domine', fontSize: 20, color: Colors.white),),
        centerTitle: true,
          ),
    );
  }
}