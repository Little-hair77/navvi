import 'package:flutter/material.dart';
import './models/place_model.dart'; // Importante!
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  
  // Lista que guardará os resultados (PlaceModel)
  List<PlaceModel> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Mantém o padrão de centralização
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8E24AA), Color(0xFF4A148C)], // Roxo Navvi
            ),
          ),
        ),
        title: const Text(
          'BUSCAR', // Você pode definir o nome que desejar aqui
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        // Garante que o ícone de voltar (back) e outros fiquem brancos
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Digite o nome de um hotel ou local...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                  // Aqui chamará a API futuramente. 
                  // Por enquanto, vamos criar um item fake para teste:
                  if (value.isNotEmpty) {
                    searchResults = [
                      PlaceModel(
                        id: '1', 
                        name: 'Resultado para: $value',
                        description: 'Este é um resultado de busca do Navvi.'
                      ),
                    ];
                  } else {
                    searchResults = [];
                  }
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final item = searchResults[index];
                
                return ListTile(
                  leading: const Icon(Icons.place),
                  title: Text(item.name),
                  subtitle: Text(item.description ?? ''), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(item: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}