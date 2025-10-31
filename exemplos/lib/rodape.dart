import 'package:flutter/material.dart';

class Rodape extends StatelessWidget {
  const Rodape({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(12),
      child: const Text(
        '© 2025 Loja Flutter - Todos os direitos reservados.',
        style: TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }
}
