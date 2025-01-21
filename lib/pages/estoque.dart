import 'package:flutter/material.dart';
import '/temas.dart';
import '/db_helper.dart';
import '/model/medicamento.dart';

class TelaEstoque extends StatefulWidget {
  const TelaEstoque({super.key});

  @override
  _TelaEstoqueState createState() => _TelaEstoqueState();
}
class _TelaEstoqueState extends State<TelaEstoque> {
  List<Medicamento> medicamentos = [];

  @override
  void initState() {
    super.initState();
    _fetchMedicamentos();
  }

  void _fetchMedicamentos() async {
    medicamentos = await DBHelper().getMedicamentos();
    setState(() {});
  }

  void _updateMedicamento(int id, int novaQuantidade) async {
    await DBHelper().updateQuantidade(id, novaQuantidade);
    _fetchMedicamentos(); 
  }

  void _deleteMedicamento(int id) async {
    await DBHelper().deleteMedicamento(id);
    _fetchMedicamentos(); // Atualiza a lista após a exclusão
  }

  void _showCaixaAtualizar(BuildContext context, int id, int initialQuantity) async {
    final TextEditingController _controller = TextEditingController(text: initialQuantity.toString());

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atualizar Quantidade'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nova quantidade',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                int novaQuantidade = int.parse(_controller.text);
                _updateMedicamento(id, novaQuantidade); // Atualiza a quantidade
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _encerrarMedicamento(int id) {
    _deleteMedicamento(id); // Remove o medicamento
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Temas.temaGeral,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'ESTOQUE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: medicamentos.length,
          itemBuilder: (context, index) {
            final medicamento = medicamentos[index];
            return CardEstoque(
              nome: medicamento.nomeMedicamento,
              dosagem: medicamento.dosagem,
              quantidade: medicamento.quantidade,
              onUpdate: () {
                _showCaixaAtualizar(context, medicamento.id!, medicamento.quantidade);
              },
              onEncerrar: () {
                _encerrarMedicamento(medicamento.id!);
              },
            );
          },
        ),
      ),
    );
  }
}
/*class _TelaEstoqueState extends State<TelaEstoque> {
  //List<Map<String, dynamic>> medicamentos = [];
  List<Medicamento> medicamentos = [];
  @override
  void initState() {
    super.initState();
    _fetchMedicamentos();
  }

  void _fetchMedicamentos() async {
    medicamentos = await DBHelper().getMedicamentos();
    setState(() {});
  }

  void _updateMedicamento(int id, int novaQuantidade) async {
    await DBHelper().updateQuantidade(id, novaQuantidade);
    _fetchMedicamentos(); // Atualiza a lista após a atualização
  }

  void _deleteMedicamento(int id) async {
    await DBHelper().deleteMedicamento(id);
    _fetchMedicamentos(); // Atualiza a lista após a exclusão
  }

  void _showCaixaAtualizar(BuildContext context, int id, int initialQuantity) async {
    final TextEditingController _controller = TextEditingController(text: initialQuantity.toString());

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Atualizar Quantidade'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nova quantidade',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                int novaQuantidade = int.parse(_controller.text);
                _updateMedicamento(id, novaQuantidade); // Atualiza a quantidade
                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _encerrarMedicamento(int id) {
    _deleteMedicamento(id); // Remove o medicamento
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Temas.temaGeral,
      home: Scaffold(
        /*appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'ESTOQUE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),*/
        body: ListView.builder(
          itemCount: medicamentos.length,
          itemBuilder: (context, index) {
            final medicamento = medicamentos[index];
            return CardEstoque(
              nome: medicamento['nomeMedicamento'],
              dosagem: medicamento['dosagem'],
              quantidade: medicamento['quantidade'],
              onUpdate: () {
                _showCaixaAtualizar(context, medicamento['id'], medicamento['quantidade']);
              },
              onEncerrar: () {
                _encerrarMedicamento(medicamento['id']);
              },
            );
          },
        ),
      ),
    );
  }
}*/
class CardEstoque extends StatelessWidget {
  final String nome;
  final String dosagem;
  final int quantidade;
  final Function() onUpdate;
  final Function() onEncerrar;

  const CardEstoque({
    Key? key,
    required this.nome,
    required this.dosagem,
    required this.quantidade,
    required this.onUpdate,
    required this.onEncerrar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nome),
        subtitle: Text('Dosagem: $dosagem | Restam: $quantidade'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: onUpdate,
              child: const Text('Atualizar'),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: onEncerrar,
              child: const Text('Encerrar'),
              //style: ElevatedButton.styleFrom(color: Colors.red), // Botão vermelho para encerrar
            ),
          ],
        ),
      ),
    );
  }
}
/* import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import '/temas.dart';

class TelaEstoque extends StatefulWidget {
  const TelaEstoque({super.key});

  @override
  _TelaEstoqueState createState() => _TelaEstoqueState();
}

class _TelaEstoqueState extends State<TelaEstoque> {
  
   // Lista de medicamentos (simulada, substitua pela sua lógica de fetch dos dados)
  final List<Map<String, dynamic>> medicamentos = [
    {'nome': 'Paracetamol', 'dosagem': '500mg', 'quantidade': 10},
    // ... outros medicamentos ...
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Temas.temaGeral,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Adicionar aqui a lógica para voltar para a página anterior
              Navigator.pop(context);
            },
          ),
          title: Text(
            'ESTOQUE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: medicamentos.length,
          itemBuilder: (context, index){
            final medicamento = medicamentos[index];
            return CardEstoque(
              nome: medicamento['nome'], 
              dosagem: medicamento['dosagem'], 
              quantidade: medicamento['quantidade'], 
              onUpdate: (){
                _showCaixaAtualizar(context, medicamento['quantidade']);
              }
            );
          }
        )
      ),
    );
  }
}

class CardEstoque extends StatelessWidget {
  final String nome;
  final String dosagem;
  final int quantidade;
  final Function() onUpdate;

  const CardEstoque({
    Key? key,
    required this.nome,
    required this.dosagem,
    required this.quantidade,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(nome),
        subtitle: Text('Dosagem: $dosagem | Restam: $quantidade'),
        trailing: ElevatedButton(
          onPressed: onUpdate, 
          child: const Text(
            'Atualizar', 
          ),
        )
        /*trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: onUpdate,
        ),*/
      ),
    );
  }
}

void _showCaixaAtualizar(BuildContext context, int initialQuantity) async {
  final TextEditingController _controller = TextEditingController(text: initialQuantity.toString());

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Atualizar Quantidade'),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Nova quantidade',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Aqui você chama a função para atualizar o banco de dados
              //int novaQuantidade = int.parse(_controller.text);
              // ... sua lógica para atualizar o banco de dados ...
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
}*/