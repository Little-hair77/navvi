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
        title: const Text('Buscar no Navvi'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
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
                  // O erro "item.description" sumirá porque o item é PlaceModel
                  subtitle: Text(item.description ?? ''), 
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // CORREÇÃO: Enviando o 'item' em vez de 'title'
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