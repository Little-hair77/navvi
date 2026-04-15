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
      backgroundColor: Colors.grey[50], // Fundo levemente cinza para destacar os cards
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
          type == 'accommodation' ? 'HOSPEDAGENS' :
          type == 'activity' ? 'O QUE FAZER?' :
          type == 'poi' ? 'PONTOS TURÍSTICOS' : 'EXPLORAR', 
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<PlaceModel>>(
        future: ApiService().fetchData(type),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF4A148C)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados', style: TextStyle(color: Colors.grey[600])));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum item encontrado.'));
          }

          final items = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(12), // Espaçamento nas bordas da lista
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              
              return GestureDetector(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => DetailScreen(item: item))
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem do Local com bordas arredondadas apenas no topo
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        child: item.imageUrl != null 
                          ? Image.network(
                              item.imageUrl!, 
                              height: 180, 
                              width: double.infinity, 
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 180,
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image, color: Colors.grey),
                              ),
                            )
                          : Container(
                              height: 180,
                              color: Colors.grey[200],
                              child: const Icon(Icons.image, color: Colors.grey, size: 50),
                            ),
                      ),
                      
                      // Conteúdo Textual
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D2D2D),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.description ?? 'Toque para ver mais detalhes sobre este local.',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                height: 1.3,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            const Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 16),
                                SizedBox(width: 4),
                                Text("4.5", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Spacer(),
                                Text(
                                  "Ver detalhes",
                                  style: TextStyle(
                                    color: Color(0xFF8E24AA),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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