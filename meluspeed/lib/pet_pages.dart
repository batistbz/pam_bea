import 'package:flutter/material.dart';

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
  final Pet? petParaEditar;

  const CadastroPetScreen({Key? key, this.petParaEditar}) : super(key: key);

  @override
  _CadastroPetScreenState createState() => _CadastroPetScreenState();
}

class _CadastroPetScreenState extends State<CadastroPetScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeController;
  late TextEditingController _tipoController;
  late TextEditingController _racaController;
  late TextEditingController _idadeController;
  late TextEditingController _fotoUrlController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.petParaEditar?.nome ?? '');
    _tipoController = TextEditingController(text: widget.petParaEditar?.tipo ?? '');
    _racaController = TextEditingController(text: widget.petParaEditar?.raca ?? '');
    _idadeController = TextEditingController(text: widget.petParaEditar?.idade.toString() ?? '');
    _fotoUrlController = TextEditingController(text: widget.petParaEditar?.fotoUrl ?? '');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tipoController.dispose();
    _racaController.dispose();
    _idadeController.dispose();
    _fotoUrlController.dispose();
    super.dispose();
  }

  Future<void> _confirmarCadastro() async {
    if (!_formKey.currentState!.validate()) return;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja realmente cadastrar este pet?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text('Confirmar'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final pet = Pet(
        nome: _nomeController.text.trim(),
        tipo: _tipoController.text.trim(),
        raca: _racaController.text.trim(),
        idade: int.parse(_idadeController.text.trim()),
        fotoUrl: _fotoUrlController.text.trim(),
      );
      Navigator.pop(context, pet);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditando = widget.petParaEditar != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditando ? 'Editar Pet' : 'Cadastrar Pet'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do pet 🐕',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe o nome do pet' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(
                  labelText: 'Tipo (cachorro, gato, pássaro, etc.) 🐾',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe o tipo do pet' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(
                  labelText: 'Raça 🐩',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v == null || v.trim().isEmpty ? 'Informe a raça' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _idadeController,
                decoration: InputDecoration(
                  labelText: 'Idade (em anos) ⏳',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Informe a idade';
                  final n = int.tryParse(v.trim());
                  if (n == null || n < 0) return 'Informe uma idade válida';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _fotoUrlController,
                decoration: InputDecoration(
                  labelText: 'Foto (URL de imagem) 📷',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Informe a URL da foto';
                  final url = v.trim();
                  final uri = Uri.tryParse(url);
                  if (uri == null || !uri.hasAbsolutePath) return 'Informe uma URL válida';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _confirmarCadastro,
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsultaPetsScreen extends StatefulWidget {
  final List<Pet> pets;

  const ConsultaPetsScreen({Key? key, required this.pets}) : super(key: key);

  @override
  _ConsultaPetsScreenState createState() => _ConsultaPetsScreenState();
}

class _ConsultaPetsScreenState extends State<ConsultaPetsScreen> {
  late List<Pet> pets;

  @override
  void initState() {
    super.initState();
    pets = List.from(widget.pets);
  }

  Future<void> _editarPet(int index) async {
    final petEditado = await Navigator.push<Pet>(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroPetScreen(petParaEditar: pets[index]),
      ),
    );
    if (petEditado != null) {
      setState(() {
        pets[index] = petEditado;
      });
    }
  }

  Future<void> _excluirPet(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirmação'),
        content: Text('Deseja realmente excluir o pet ${pets[index].nome}?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: Text('Excluir'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        pets.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    // Ao sair, retorna a lista atualizada para a tela anterior
    Navigator.pop(context, pets);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pets Cadastrados'),
      ),
      body: pets.isEmpty
          ? Center(child: Text('Nenhum pet cadastrado.'))
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pet.fotoUrl),
                      radius: 30,
                      onBackgroundImageError: (_, __) {},
                    ),
                    title: Text('${pet.nome} (${pet.tipo})'),
                    subtitle: Text('Raça: ${pet.raca} - Idade: ${pet.idade} anos'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editarPet(index),
                          tooltip: 'Editar',
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _excluirPet(index),
                          tooltip: 'Excluir',
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