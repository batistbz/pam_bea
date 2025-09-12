import 'package:flutter/material.dart';
import 'main.dart';

class PetFormScreen extends StatefulWidget {
  final Pet? pet;

  const PetFormScreen({super.key, this.pet});

  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nomeController;
  late TextEditingController _tipoController;
  late TextEditingController _racaController;
  late TextEditingController _idadeController;
  late TextEditingController _fotoUrlController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.pet?.nome ?? '');
    _tipoController = TextEditingController(text: widget.pet?.tipo ?? '');
    _racaController = TextEditingController(text: widget.pet?.raca ?? '');
    _idadeController = TextEditingController(text: widget.pet?.idade.toString() ?? '');
    _fotoUrlController = TextEditingController(text: widget.pet?.fotoUrl ?? '');
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

  void _savePet() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Confirmar Cadastro'),
          content: Text('Deseja realmente cadastrar este pet?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                final pet = Pet(
                  nome: _nomeController.text.trim(),
                  tipo: _tipoController.text.trim(),
                  raca: _racaController.text.trim(),
                  idade: int.parse(_idadeController.text.trim()),
                  fotoUrl: _fotoUrlController.text.trim(),
                );
                Navigator.pop(context); // fecha o diálogo
                Navigator.pop(context, pet); // retorna o pet para a tela anterior
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.pet != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Pet' : 'Cadastrar Pet'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do pet 🐕',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome do pet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tipoController,
                decoration: InputDecoration(
                  labelText: 'Tipo (cachorro, gato, pássaro, etc.) 🐾',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o tipo do pet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(
                  labelText: 'Raça 🐩',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a raça do pet';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _idadeController,
                decoration: InputDecoration(
                  labelText: 'Idade (em anos) ⏳',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a idade do pet';
                  }
                  final idade = int.tryParse(value.trim());
                  if (idade == null || idade < 0) {
                    return 'Informe uma idade válida';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fotoUrlController,
                decoration: InputDecoration(
                  labelText: 'Foto (URL de imagem) 📷',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe a URL da foto';
                  }
                  final url = value.trim();
                  if (!Uri.tryParse(url)!.hasAbsolutePath) {
                    return 'Informe uma URL válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePet,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}