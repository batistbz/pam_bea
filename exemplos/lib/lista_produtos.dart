import 'package:flutter/material.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({super.key});

  final List<String> produtos = const [
    'Camisa Flutter',
    'Boné Dart',
    'Adesivo Widget',
    'Caneca Flutter',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: Text(produtos[index]),
        );
      },
    );
  }
}
