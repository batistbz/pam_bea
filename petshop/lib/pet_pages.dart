import 'package:flutter/material.dart';

class Pet {
  String name;
  String type;
  String breed;
  int age;
  String photoUrl;

  Pet({
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.photoUrl,
  });
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pet> pets = [];

  void addPet(Pet pet) => setState(() => pets.add(pet));
  void updatePet(int index, Pet pet) => setState(() => pets[index] = pet);
  void removePet(int index) => setState(() => pets.removeAt(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PetShop - CRUD Simples'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Bem-vindo ao PetShop',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildMenuCard(
                    icon: Icons.add,
                    label: 'Cadastrar Pet',
                    onTap: () async {
                      final result = await Navigator.push<Pet>(
                        context,
                        MaterialPageRoute(builder: (_) => PetFormPage()),
                      );
                      if (result != null) {
                        final confirmed = await _showConfirmDialog(
                            context, 'Deseja realmente cadastrar este pet?');
                        if (confirmed) addPet(result);
                      }
                    },
                  ),
                  _buildMenuCard(
                    icon: Icons.list_alt,
                    label: 'Consultar Pets',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetListPage(
                            pets: pets,
                            onEdit: (i) async {
                              final edited = await Navigator.push<Pet>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PetFormPage(pet: pets[i]),
                                ),
                              );
                              if (edited != null) {
                                final confirmed = await _showConfirmDialog(
                                    context,
                                    'Deseja realmente salvar as alterações?');
                                if (confirmed) updatePet(i, edited);
                              }
                            },
                            onDelete: (i) async {
                              final confirmed = await _showConfirmDialog(
                                  context,
                                  'Deseja realmente excluir o pet ${pets[i].name}?');
                              if (confirmed) removePet(i);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context, String message) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Confirmação'),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text('Cancelar')),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('Confirmar')),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildMenuCard(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48),
              SizedBox(height: 8),
              Text(label,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
            ],
          ),
        ),
      ),
    );
  }
}

class PetFormPage extends StatefulWidget {
  final Pet? pet;
  PetFormPage({this.pet});
  @override
  _PetFormPageState createState() => _PetFormPageState();
}

class _PetFormPageState extends State<PetFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl, _typeCtrl, _breedCtrl, _ageCtrl, _photoCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.pet?.name ?? '');
    _typeCtrl = TextEditingController(text: widget.pet?.type ?? '');
    _breedCtrl = TextEditingController(text: widget.pet?.breed ?? '');
    _ageCtrl = TextEditingController(
        text: widget.pet != null ? widget.pet!.age.toString() : '');
    _photoCtrl = TextEditingController(text: widget.pet?.photoUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.pet == null ? 'Cadastrar Pet' : 'Editar Pet')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _buildField(_nameCtrl, 'Nome do pet', Icons.pets),
            _buildField(_typeCtrl, 'Tipo (cachorro, gato...)', Icons.pets),
            _buildField(_breedCtrl, 'Raça', Icons.info_outline),
            _buildField(_ageCtrl, 'Idade', Icons.timelapse, number: true),
            _buildField(_photoCtrl, 'Foto (URL)', Icons.photo),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Salvar'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  final pet = Pet(
                    name: _nameCtrl.text.trim(),
                    type: _typeCtrl.text.trim(),
                    breed: _breedCtrl.text.trim(),
                    age: int.tryParse(_ageCtrl.text.trim()) ?? 0,
                    photoUrl: _photoCtrl.text.trim(),
                  );
                  Navigator.pop(context, pet);
                }
              },
            )
          ]),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String label, IconData icon,
      {bool number = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: c,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
        validator: (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null,
      ),
    );
  }
}

class PetListPage extends StatelessWidget {
  final List<Pet> pets;
  final Future<void> Function(int index) onDelete;
  final Future<void> Function(int index) onEdit;
  PetListPage({required this.pets, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pets Cadastrados')),
      body: pets.isEmpty
          ? Center(child: Text('Nenhum pet cadastrado.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: pets.length,
              itemBuilder: (context, i) {
                final pet = pets[i];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: Image.network(
                          pet.photoUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.pets, size: 40),
                          ),
                        ),
                      ),
                    ),
                    title: Text('${pet.name} — ${pet.type}'),
                    subtitle: Text('${pet.breed} • ${pet.age} anos'),
                    trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => onEdit(i)),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => onDelete(i)),
                        ]),
                  ),
                );
              },
            ),
    );
  }
}
