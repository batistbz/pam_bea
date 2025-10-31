import 'package:flutter/material.dart';

class Cabecalho extends StatelessWidget {
  const Cabecalho({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blueAccent,
      child: const Text(
        'Bem-vindo à Loja Flutter!',
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    );
  }
}
