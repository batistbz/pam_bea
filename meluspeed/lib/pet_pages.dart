import 'package:flutter/material.dart';

// -------------------- TELA 1: HOME --------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Fundo com imagem de patinhas
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/patinhas.png"),
            fit: BoxFit.cover,   // cobre a tela toda
            opacity: 0.08,       // deixa clarinho, como papel de parede
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🐾 Pet Shop Fofo",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text("Cuidando com amor dos seus bichinhos"),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CadastroPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                icon: const Icon(Icons.add),
                label: const Text("Cadastrar Pet"),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaPetsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                ),
                icon: const Icon(Icons.list),
                label: const Text("Consultar Pets"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------- TELA 2: CADASTRAR PET --------------------
class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController fotoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastrar Novo Pet")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: "Nome do Pet")),
            const SizedBox(height: 10),
            TextField(controller: tipoController, decoration: const InputDecoration(labelText: "Tipo")),
            const SizedBox(height: 10),
            TextField(controller: racaController, decoration: const InputDecoration(labelText: "Raça")),
            const SizedBox(height: 10),
            TextField(controller: idadeController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Idade (anos)")),
            const SizedBox(height: 10),
            TextField(controller: fotoController, decoration: const InputDecoration(labelText: "Foto (URL)")),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Aqui você pode salvar os dados (no futuro podemos ligar com a lista de pets)
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Salvar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Voltar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- TELA 3: LISTA DE PETS --------------------
class ListaPetsPage extends StatelessWidget {
  const ListaPetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pets Cadastrados")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.pets, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Nenhum pet cadastrado ainda",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CadastroPage()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              child: const Text("Cadastrar Primeiro Pet"),
            ),
          ],
        ),
      ),
    );
  }
}
