import 'package:flutter/material.dart';


class BotaoPersonalizado extends StatelessWidget {
  final String texto;
  final VoidCallback aoClicar;

  const BotaoPersonalizado({super.key, required this.texto, required this.aoClicar});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: aoClicar,
      child: Text(texto),
    );
  }
}

final List<Map<String, String>> usuariosMock = [
  {'nome': 'Beatriz', 'email': 'bia@email.com'},
  {'nome': 'Lucas', 'email': 'lucas@email.com'},
];

