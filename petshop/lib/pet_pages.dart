import 'package:flutter/material.dart';

class Pet {
  String nome;
  String tipo;
  String raca;
  String idade;
  String fotoUrl;

  Pet({
    required this.nome,
    required this.tipo,
    required this.raca,
    required this.idade,
    required this.fotoUrl,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pet> pets = [];

  void adicionarPet(Pet pet) {
    setState(() {
      pets.add(pet);
    });
  }

  void editarPet(int index, Pet novoPet) {
    setState(() {
      pets[index] = novoPet;
    });
  }

  void removerPet(int index) {
    setState(() {
      pets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PetShop')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text("Cadastrar Pet"),
              onPressed: () async {
                final pet = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PetFormPage()),
                );
                if (pet != null) adicionarPet(pet);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.pets),
              label: const Text("Consultar Pets"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PetListPage(
                      pets: pets,
                      onEdit: editarPet,
                      onDelete: removerPet,
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

class PetFormPage extends StatefulWidget {
  final Pet? pet;
  final int? index;

  const PetFormPage({super.key, this.pet, this.index});

  @override
  State<PetFormPage> createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  final _formKey = GlobalKey<FormState>();
  final nomeCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();
  final racaCtrl = TextEditingController();
  final idadeCtrl = TextEditingController();
  final fotoCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pet != null) {
      nomeCtrl.text = widget.pet!.nome;
      tipoCtrl.text = widget.pet!.tipo;
      racaCtrl.text = widget.pet!.raca;
      idadeCtrl.text = widget.pet!.idade;
      fotoCtrl.text = widget.pet!.fotoUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.pet == null ? "Cadastrar Pet" : "Editar Pet")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _campoTexto("Nome", nomeCtrl),
              _campoTexto("Tipo", tipoCtrl),
              _campoTexto("Raça", racaCtrl),
              _campoTexto("Idade", idadeCtrl, teclado: TextInputType.number),
              _campoTexto("Foto (URL)", fotoCtrl),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Confirmar Cadastro"),
                        content: const Text("Deseja realmente salvar este pet?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text("Cancelar"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final novoPet = Pet(
                                nome: nomeCtrl.text,
                                tipo: tipoCtrl.text,
                                raca: racaCtrl.text,
                                idade: idadeCtrl.text,
                                fotoUrl: fotoCtrl.text,
                              );
                              Navigator.pop(ctx); // Fecha o AlertDialog
                              Navigator.pop(context, novoPet); // Retorna para a tela anterior
                            },
                            child: const Text("Salvar"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text("Salvar"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _campoTexto(String label, TextEditingController ctrl, {TextInputType teclado = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: ctrl,
        keyboardType: teclado,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? "Preencha este campo" : null,
      ),
    );
  }
}

class PetListPage extends StatelessWidget {
  final List<Pet> pets;
  final Function(int, Pet) onEdit;
  final Function(int) onDelete;

  const PetListPage({super.key, required this.pets, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pets Cadastrados")),
      body: pets.isEmpty
          ? const Center(child: Text("Nenhum pet cadastrado"))
          : ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, i) {
                final pet = pets[i];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: pet.fotoUrl.isNotEmpty
                        ? Image.network(pet.fotoUrl, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.pets, size: 40),
                    title: Text("${pet.nome} (${pet.tipo})"),
                    subtitle: Text("Raça: ${pet.raca} | Idade: ${pet.idade}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final petEditado = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => PetFormPage(pet: pet, index: i)),
                            );
                            if (petEditado != null) onEdit(i, petEditado);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Excluir Pet"),
                                content: Text("Deseja realmente excluir ${pet.nome}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("Cancelar"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      onDelete(i);
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text("Excluir"),
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
