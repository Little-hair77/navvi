import 'package:flutter/material.dart';
import 'detail_screen.dart';

class ListScreen extends StatelessWidget {
  final String type;

  const ListScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(type.toUpperCase()),
      ),
      body: ListView.builder(
        itemCount: 10, // futuramente vem da API
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(Icons.image),
              title: Text('Item $index'),
              subtitle: const Text('Descrição breve'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(title: 'Item $index'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}