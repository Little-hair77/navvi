import 'package:flutter/material.dart';
import 'detail_screen.dart';
import './models/place_model.dart';
import './services/api_service.dart';

class ListScreen extends StatelessWidget {
  final String type;

  const ListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type.toUpperCase()),
      ),
      body: FutureBuilder<List<PlaceModel>>(
        future: ApiService().fetchData(type), // Chama a API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); // Carregando
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}')); // Deu ruim
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum item encontrado.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: ListTile(
                  leading: item.imageUrl != null 
                    ? Image.network(item.imageUrl!, width: 50, fit: BoxFit.cover)
                    : const Icon(Icons.image),
                  title: Text(item.name),
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (_) => DetailScreen(item: item))
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}