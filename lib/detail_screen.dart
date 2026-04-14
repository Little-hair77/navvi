import 'package:flutter/material.dart';
import './models/place_model.dart';

class DetailScreen extends StatelessWidget {
  final PlaceModel item; 

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent, // Necessário para o degradê aparecer
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF8E24AA), Color(0xFF4A148C)], // Mesmas cores da Home
            ),
          ),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        // Garante que o ícone de voltar fique branco
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem Dinâmica vinda da API
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.grey[300],
              child: item.imageUrl != null
                  ? Image.network(
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      // Tratamento caso a imagem falhe ao carregar
                      errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.broken_image, size: 80),
                    )
                  : const Center(child: Icon(Icons.image, size: 80)),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    'Sobre',
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.purple
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description ?? 'Nenhuma descrição detalhada disponível para este local no momento.',
                    style: const TextStyle(fontSize: 16, height: 1.5),
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