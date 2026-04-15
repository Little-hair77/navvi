import 'package:flutter/material.dart';
import './models/place_model.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<PlaceModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF4A148C), // Roxo sólido para foco
        title: const Text(
          'BUSCAR',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Campo de busca com design "Soft"
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                    if (value.isNotEmpty) {
                      searchResults = [
                        PlaceModel(
                          id: '1',
                          name: 'Resultado para: $value',
                          description: 'Toque para ver detalhes do local encontrado.',
                          imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=500', // Exemplo
                        ),
                      ];
                    } else {
                      searchResults = [];
                    }
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'O que você está procurando?',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Color(0xFF4A148C)),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
          ),

          Expanded(
            child: query.isEmpty 
              ? _buildEmptyState() 
              : _buildResultsList(),
          ),
        ],
      ),
    );
  }

  // Widget para quando a tela de busca estiver vazia
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 15),
          Text(
            "Encontre seu próximo destino",
            style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          const Text(
            "Digite algo para começar.",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // Widget para a lista de resultados estilizada
  Widget _buildResultsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[100]!),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageUrl != null 
                ? Image.network(item.imageUrl!, width: 60, height: 60, fit: BoxFit.cover)
                : Container(width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.place, color: Colors.grey)),
            ),
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.description ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(item: item)),
              );
            },
          ),
        );
      },
    );
  }
}