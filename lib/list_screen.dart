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
        title: Text(
          // Aqui você define o que cada categoria deve exibir
          type == 'accommodation' ? 'Hospedagens' :
          type == 'activity' ? 'O que fazer' :
          type == 'poi' ? 'Pontos Turísticos' : 'Explorar', 
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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