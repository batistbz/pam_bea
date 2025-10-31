import 'package:flutter/material.dart';
import 'cabecalho.dart';
import 'lista_produtos.dart';
import 'rodape.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Flutter',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loja Flutter')),
      body: Column(
        children: const [
          Cabecalho(),
          Expanded(child: ListaProdutos()),
          Rodape(),
        ],
      ),
    );
  }
}