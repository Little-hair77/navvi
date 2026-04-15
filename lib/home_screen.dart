import 'package:flutter/material.dart';
import 'search_screen.dart';
import 'list_screen.dart';

void main() {
  runApp(NavviApp());
}

class NavviApp extends StatefulWidget {
  NavviApp({super.key});

  @override
  State<NavviApp> createState() => _NavviAppState();
}

class _NavviAppState extends State<NavviApp> {
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Explore o Mundo',
      'desc': 'Encontre as melhores acomodações com o Navvi.',
      'img': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800'
    },
    {
      'title': 'Viva Experiências',
      'desc': 'Atividades inesquecíveis em cada destino.',
      'img': 'https://images.unsplash.com/photo-1530789253388-582c481c54b0?w=800'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF8E24AA), Color(0xFF4A148C)],
              ),
            ),
          ),
          title: const Text(
            'NAVVI',
            style: TextStyle(
              fontFamily: 'Georgia',
              fontWeight: FontWeight.w900,
              letterSpacing: 4.0,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        body: CustomScrollView(
          slivers: [
            // 🔥 CORRIGIDO AQUI
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      itemCount: carouselItems.length,
                      controller: PageController(viewportFraction: 0.9),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(carouselItems[index]['img']!),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.purple.withOpacity(0.8)
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  carouselItems[index]['title']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  carouselItems[index]['desc']!,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Bem-vindo ao",
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                        Text("Navvi Explorer",
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
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
                    'https://emtodolugar.facha.edu.br/2021/07/12/pontos-turisticos-para-visitar-pos-pandemia/',
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