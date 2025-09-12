import 'package:flutter/material.dart';
import 'pet_pages.dart';

void main() {
  runApp(PetShopApp());
}

class PetShopApp extends StatefulWidget {
  @override
  _PetShopAppState createState() => _PetShopAppState();
}

class _PetShopAppState extends State<PetShopApp> {
  List<Pet> pets = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Petshop',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(
        onCadastrarPet: () async {
          final pet = await Navigator.push<Pet>(
            context,
            MaterialPageRoute(
              builder: (_) => CadastroPetScreen(),
            ),
          );
          if (pet != null) {
            setState(() {
              pets.add(pet);
            });
          }
        },
        onConsultarPets: () async {
          final updatedPets = await Navigator.push<List<Pet>>(
            context,
            MaterialPageRoute(
              builder: (_) => ConsultaPetsScreen(pets: pets),
            ),
          );
          if (updatedPets != null) {
            setState(() {
              pets = updatedPets;
            });
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onCadastrarPet;
  final VoidCallback onConsultarPets;

  const HomeScreen({
    Key? key,
    required this.onCadastrarPet,
    required this.onConsultarPets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petshop'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.add),
                label: Text('Cadastrar Pet'),
                onPressed: onCadastrarPet,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.list),
                label: Text('Consultar Pets'),
                onPressed: onConsultarPets,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}