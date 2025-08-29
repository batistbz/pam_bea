import 'package:flutter/material.dart';
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _tarefas = [];
 
  //criando metodo para salvar tarefas
  void _adicionarTarefas(String url, String descricao, BuildContext context) {
    //metodos set
    setState(() {
      _tarefas.add({'url': url, 'descricao': descricao});
    });
  }
 
  //Criando um modal
  //metodo void modal cadastrar
  void _showForm(BuildContext context) {
    //criando as variaveis de controller
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            //Retangulo vai se adaptar ao conteudo aos componentes
            child: Container(
              //Criando o container
              //margem interna
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cadastrar Atividade",
                        style: TextStyle(
                          fontFamily: "Verdana",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //ação do icone botão fechar
 
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: imageController,
                    decoration: InputDecoration(
                      labelText: 'URL da Imagem Tarefa',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição da Tarefa',
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ação do botão salvar
                          _adicionarTarefas(
                            imageController.text,
                            descricaoController.text,
                            context,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tarefa cadastrada com Sucesso'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black38,
                        ),
                        child: Text(
                          'Cadastar',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //ação do botão
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black38,
                        ),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
 
  //Criando Modal de Editar
  //Criando um modal
  //metodo void Editar
  void _showFormEdit(BuildContext context) {
    //criando as variaveis de controller
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            //Retangulo vai se adaptar ao conteudo aos componentes
            child: Container(
              //Criando o container
              //margem interna
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Editar Atividade",
                        style: TextStyle(
                          fontFamily: "Verdana",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          //ação do icone botão fechar
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: imageController,
                    decoration: InputDecoration(
                      labelText: 'URL da Imagem Tarefa',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição da Tarefa',
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          //ação do botão salvar
                        },
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          //ação do botão
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tarefas"),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          return Tarefas(
            _tarefas[index]['url']!,
            _tarefas[index]['descricao']!,
            () => _showFormEdit(context),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ação do botão
          _showForm(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
 
//Criando a classe Tarefas
class Tarefas extends StatelessWidget {
  final String imagem_url;
  final String descricao;
  final VoidCallback onEdit;
 
  const Tarefas(this.imagem_url, this.descricao, this.onEdit, {super.key});
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(color: Color.fromARGB(255, 115, 211, 214), height: 140),
          Container(
            color: Colors.white,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                    child: Image.network(imagem_url),
                  ),
                ),
                Expanded(
                  child: Text(descricao, style: TextStyle(fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: onEdit,
                    child: Icon(Icons.edit),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}