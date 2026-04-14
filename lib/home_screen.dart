import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'list_screen.dart';

void main() {
  runApp(const NavviApp());
}

class NavviApp extends StatelessWidget {
  const NavviApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Bem-vindo ao",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Text("Navvi Explorer",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildListDelegate([
                  _buildModernCard(
                    context,
                    'Acomodações',
                    Icons.hotel,
                    'accommodation',
                    'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500',
                  ),
                  _buildModernCard(
                    context,
                    'Atividades',
                    Icons.explore,
                    'activity',
                    'https://images.unsplash.com/photo-1530789253388-582c481c54b0?w=500',
                  ),
                  _buildModernCard(
                    context,
                    'Pontos Turísticos',
                    Icons.camera_alt,
                    'poi',
                    'https://images.unsplash.com/photo-1500835595366-2047f4749f7e?w=500',
                  ),
                  _buildModernCard(
                    context,
                    'Cultura',
                    Icons.museum,
                    'event',
                    'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NOVA FUNÇÃO (corrige o erro)
  Widget _buildModernCard(
    BuildContext context,
    String title,
    IconData icon,
    String type,
    String imageUrl,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ListScreen(type: type),
          ),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}