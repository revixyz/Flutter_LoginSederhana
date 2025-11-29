import 'package:flutter/material.dart';
import 'package:login_app/screens/home_screen.dart';

class Presensi extends StatefulWidget {
  const Presensi({super.key});

  @override
  State<Presensi> createState() => _PresensiState();
}

class _PresensiState extends State<Presensi> {
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
        title: const Text('Presensi', style: TextStyle(fontFamily: 'Domine', fontSize: 20, color: Colors.white),),
        centerTitle: true,
          ),
    );
  }
}