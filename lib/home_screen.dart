import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'list_screen.dart';
import 'detail_screen.dart';

void main() {
  runApp(const NavviApp());
}

class NavviApp extends StatelessWidget {
  const NavviApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navvi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(context, 'Acomodações', Icons.hotel, 'accommodation'),
            _buildCard(context, 'Atividades', Icons.sports_esports, 'activity'),
            _buildCard(context, 'Pontos de Interesse', Icons.place, 'poi'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListScreen(type: type),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 10),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
