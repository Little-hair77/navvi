import 'package:flutter/material.dart';
import 'package:navvi/on_screen.dart';
import 'search_screen.dart';
import 'list_screen.dart';
import 'on_screen.dart'; 
import 'dart:async';

class NavviApp extends StatefulWidget {
  const NavviApp({super.key});

  @override
  State<NavviApp> createState() => _NavviAppState();
}

class _NavviAppState extends State<NavviApp> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Explore o Mundo',
      'desc': 'Encontre as melhores acomodações.',
      'img': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800'
    },
    {
      'title': 'Viva Experiências',
      'desc': 'Atividades inesquecíveis te esperam.',
      'img': 'https://images.unsplash.com/photo-1530789253388-582c481c54b0?w=800'
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < carouselItems.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false, // Título à esquerda para um ar mais moderno
        elevation: 0,
        backgroundColor: const Color(0xFF4A148C),
        title: const Text(
          'NAVVI',
          style: TextStyle(
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. Saudação
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Olá, Explorador!", style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                  const Text("Para onde vamos?", 
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D))),
                ],
              ),
            ),
          ),

          // 2. Carrossel Refinado
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: PageView.builder(
                controller: _pageController,
                itemCount: carouselItems.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      return Center(child: child);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
                        ],
                        image: DecorationImage(
                          image: NetworkImage(carouselItems[index]['img']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                          ),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(carouselItems[index]['title']!, 
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(carouselItems[index]['desc']!, 
                              style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 3. Título das Categorias
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("Categorias", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),

          // 4. Grid de Categorias
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.1, // Deixa os cards um pouco mais largos
              ),
              delegate: SliverChildListDelegate([
                _buildModernCard(context, 'Hospedagem', Icons.hotel_rounded, 'accommodation', 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=500'),
                _buildModernCard(context, 'Atividades', Icons.local_activity_rounded, 'activity', 'https://images.unsplash.com/photo-1530789253388-582c481c54b0?w=500'),
                _buildModernCard(context, 'Turismo', Icons.camera_rounded, 'poi', 'https://images.unsplash.com/photo-1500835595366-2047f4749f7e?w=500'),
                _buildModernCard(context, 'Cultura', Icons.museum_rounded, 'event', 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500'),
              ]),
            ),
          ),

          // 5. Rodapé Clean
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(vertical: 30),
              color: Colors.grey[50],
              child: Column(
                children: [
                  const Text("NAVVI", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey)),
                  TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SobreScreen())),
                    child: const Text("Sobre o projeto", style: TextStyle(color: Color(0xFF8E24AA))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF4A148C),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favs"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildModernCard(BuildContext context, String title, IconData icon, String type, String imageUrl) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ListScreen(type: type))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.6)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}