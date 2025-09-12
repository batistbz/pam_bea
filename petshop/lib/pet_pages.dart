import 'package:flutter/material.dart';

class AddPetPage extends StatelessWidget {
  const AddPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Pet')),
      body: Center(child: Text('Tela de adicionar pet')),
    );
  }
}

class ViewPetsPage extends StatelessWidget {
  const ViewPetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visualizar Pets')),
      body: Center(child: Text('Tela de visualização de pets')),
    );
  }
}
