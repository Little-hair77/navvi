import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF4A148C),
        title: const Text(
          'SOBRE O NAVVI',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.explore_rounded, size: 80, color: Color(0xFF4A148C)),
                  const SizedBox(height: 10),
                  const Text(
                    "NAVVI",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  Text("Versão 1.0.0", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Nossa Missão"),
                  const SizedBox(height: 12),
                  _buildContentText(
                    "O Navvi nasceu da paixão por descobrir novos lugares. Nossa missão é simplificar a busca por destinos incríveis, conectando você à cultura e às experiências únicas em cada canto do planeta.",
                  ),
                  
                  const SizedBox(height: 35),
                  
                  _buildSectionTitle("Desenvolvido por"),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF8E24AA),
                          child: const Icon(Icons.person, color: Colors.white, size: 35),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Pablo Henrique Azevedo Gomes da Silva",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color(0xFF2D2D2D),
                                ),
                              ),
                              Text(
                                "Mobile Developer",
                                style: TextStyle(color: Colors.grey[600], fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 35),
                  
                  _buildSectionTitle("Tecnologia"),
                  const SizedBox(height: 12),
                  _buildContentText(
                    "Projeto construído em Flutter, utilizando a API Open Data Hub para integração de dados em tempo real.",
                  ),

                  const SizedBox(height: 50),
                  
                  const Center(
                    child: Text(
                      "© 2026 Navvi Explorer",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)),
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.6),
    );
  }
}