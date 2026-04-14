import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.image, size: 80)),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Descrição completa do local...',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Contato: exemplo@email.com'),
            ),
          ],
        ),
      ),
    );
  }
}