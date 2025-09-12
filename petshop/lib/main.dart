import 'package:flutter/material.dart';
import 'pet_form.dart';

void main() {
  runApp(PetShopApp());
}

class Pet {
  String nome;
  String tipo;
  String raca;
  int idade;
  String fotoUrl;

  Pet({
    required this.nome,
    required this.tipo,
    required this.raca,
    required this.idade,
    required this.fotoUrl,
  });
}

class PetShopApp extends StatefulWidget {
  const PetShopApp({super.key});

  @override
  State<PetShopApp> createState() => _PetShopAppState();
}

class _PetShopAppState extends State<PetShopApp> {
  List<Pet> pets = [];

  void _addPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  void _updatePet(int index, Pet pet) {
    setState(() {
      pets[index] = pet;
    });
  }

  void _removePet(int index) {
    setState(() {
      pets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(
        pets: pets,
        onAddPet: _addPet,
        onUpdatePet: _updatePet,
        onRemovePet: _removePet,
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  final List<Pet> pets;
  final Function(Pet) onAddPet;
  final Function(int, Pet) onUpdatePet;
  final Function(int) onRemovePet;

  const HomeScreen({
    super.key,
    required this.pets,
    required this.onAddPet,
    required this.onUpdatePet,
    required this.onRemovePet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Shop'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Cadastrar Pet'),
              onPressed: () async {
                final Pet? newPet = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PetFormScreen(),
                  ),
                );
                if (newPet != null) {
                  onAddPet(newPet);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.list),
              label: Text('Consultar Pets'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PetListScreen(
                      pets: pets,
                      onUpdatePet: onUpdatePet,
                      onRemovePet: onRemovePet,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class PetListScreen extends StatelessWidget {
  final List<Pet> pets;
  final Function(int, Pet) onUpdatePet;
  final Function(int) onRemovePet;

  const PetListScreen({
    super.key,
    required this.pets,
    required this.onUpdatePet,
    required this.onRemovePet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pets'),
      ),
      body: pets.isEmpty
          ? Center(child: Text('Nenhum pet cadastrado.'))
          : ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pet.fotoUrl),
                      onBackgroundImageError: (_, e) {},
                    ),
                    title: Text('${pet.nome} (${pet.tipo})'),
                    subtitle: Text('Raça: ${pet.raca} - Idade: ${pet.idade} anos'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final Pet? editedPet = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PetFormScreen(pet: pet),
                              ),
                            );
                            if (editedPet != null) {
                              onUpdatePet(index, editedPet);
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Confirmar Exclusão'),
                                content: Text('Deseja realmente excluir o pet ${pet.nome}?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  TextButton(
                                    child: Text('Excluir'),
                                    onPressed: () {
                                      onRemovePet(index);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}