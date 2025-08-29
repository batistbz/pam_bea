import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  
  void _showForm(BuildContext context) {
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        ),
        child:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cadastrar Atividade",
                  style: TextStyle(
                    fontFamily:"Verdana",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();  
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                  labelText: 'URL da Imagem da Tarefa'
                ),
              ),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                    child: Text('Cadastrar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red),
                    child: Text('Cancelar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        )
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
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        children: [
          Tarefas(
            "https://cdn2.hubspot.net/hubfs/475261/7._Como_gerenciar_melhor_seu_tempo_para_executar_todas_as_tarefas_do_dia.jpg",
          ),
          Tarefas(
            "https://www.psicologosberrini.com.br/wp-content/uploads/lista-de-tarefas-para-mudar-sua-vida.jpeg",
          ),
          Tarefas(
            "https://seculoxximinas.com.br/fgv/wp-content/uploads/2018/12/Webp.net-compress-image-20.jpg",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
 
  void _showEditar (BuildContext context) {
    final TextEditingController simboloController = TextEditingController();
    final TextEditingController descreverController = TextEditingController();
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        ),
        child:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Editar Atividade",
                  style: TextStyle(
                    fontFamily:"Verdana",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();  
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: simboloController,
                decoration: InputDecoration(
                  labelText: 'URL da Imagem da Tarefa'
                ),
              ),
              TextField(
                controller: descreverController,
                decoration: InputDecoration(
                  labelText: 'Descrição da Tarefa',
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow),
                    child: Text('Editar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red),
                    child: Text('Cancelar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        )
        ),
        );
      },
      );
  }

  const Tarefas(this.imagem_url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: [
          Container(color: Colors.purpleAccent, height: 140),
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
                  child: Text(
                    "Tarefa - Descrição",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0), 
                  child: ElevatedButton(
                    onPressed: () {
                      _showEditar(context);
                    },
                    child: Icon(Icons.edit), // edição dos botôes de lápis
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