import 'package:flutter/material.dart';

// Modelo básico do Pet
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

class CadastroPetScreen extends StatefulWidget {
  @override
  _CadastroPetScreenState createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _tipoController = TextEditingController();
  final _racaController = TextEditingController();
  final _idadeController = TextEditingController();
  final _fotoUrlController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _tipoController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _fotoUrlController.dispose();
    super.dispose();
  }

  void _salvarPet() {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        nome: _nomeController.text.trim(),
        tipo: _tipoController.text.trim(),
        raca: _racaController.text.trim(),
        idade: int.tryParse(_idadeController.text.trim()) ?? 0,
        fotoUrl: _fotoUrlController.text.trim(),
      );
      Navigator.pop(context, pet);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Pet')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
                validator: (v) => v == null || v.isEmpty ? 'Informe o tipo' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(labelText: 'Raça'),
                validator: (v) => v == null || v.isEmpty ? 'Informe a raça' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _idadeController,
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a idade';
                  final n = int.tryParse(v);
                  if (n == null || n < 0) return 'Idade inválida';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _fotoUrlController,
                decoration: InputDecoration(labelText: 'Foto (URL)'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Informe a URL da foto';
                  final uri = Uri.tryParse(v);
                  if (uri == null || !uri.hasAbsolutePath) return 'URL inválida';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarPet,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsultaPetsScreen extends StatelessWidget {
  final List<Pet> pets;
  ConsultaPetsScreen({required this.pets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pets')),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return ListTile(
            leading: pet.fotoUrl.isNotEmpty
                ? Image.network(pet.fotoUrl, width: 50, height: 50, fit: BoxFit.cover)
                : Icon(Icons.pets),
            title: Text(pet.nome),
            subtitle: Text('${pet.tipo} • ${pet.raca} • ${pet.idade} anos'),
          );
        },
      ),
    );
  }
}

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