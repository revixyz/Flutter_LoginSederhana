import 'package:flutter/material.dart';
import 'package:login_app/login/login_page.dart';
import 'package:login_app/screens/berita.dart';
import 'package:login_app/screens/presensi.dart';
import'package:login_app/main.dart';
import 'package:login_app/screens/news_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
     int getCrossAxisCount(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    if (w < 600) return 2;  // HP
    if (w < 900) return 3;  // tablet portrait
    return 2;               // tablet landscape / desktop
  }
    List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Presensi',
        'icon': Icons.list_alt,
        'color': Colors.blue,
        'route': '/presensi',
      },
      {
        'title': 'Berita',
        'icon': Icons.newspaper,
        'color': Colors.orange,
        'route': '/berita',
      },
      {
        'title': 'Galeri',
        'icon': Icons.photo_album,
        'color': Colors.green,
        'route': '/galeri',
      },
      {
        'title': 'Agenda',
        'icon': Icons.event,
        'color': Colors.red,
        'route': '/agenda',
      },
      {
        'title': 'Setting',
        'icon': Icons.settings,
        'color': Colors.purple,
        'route': '/setting',
      },
      {
        'title': 'Contact',
        'icon': Icons.contact_mail,
        'color': Colors.teal,
        'route': '/contact',
      },
      {
        'title': 'News',
        'icon': Icons.newspaper,
        'color': Colors.lime,
        'route': '/news', 
      }
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text('Beranda', style: TextStyle(fontFamily: 'Domine', fontSize: 20, color: Colors.white),),
        centerTitle: true,
      ),
      body: Padding(padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index){
          final item = menuItems[index];
          return MenuCard(
            title: item['title'],
            icon: item['icon'],
            color: item['color'],
            route: item['route'],
          );
        }
        ),
      )
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0, color: color),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Domine',
                ),
              ),
            ],
          ),
        ),
    );
  }
}