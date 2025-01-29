import 'package:flutter/material.dart';
//import '/temas.dart';
import '/db_helper.dart';
import '/model/medicamento.dart';
import 'package:go_router/go_router.dart';

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
  try {
    List<Medicamento> fetchedMedicamentos = await DBHelper().getMedicamentos(); // Adicione await aqui
    medicamentos = fetchedMedicamentos; // Atualiza a lista de medicamentos
    debugPrint('Medicamentos: $medicamentos'); // Verifique se os medicamentos estão sendo buscados
    setState(() {});
  } catch (e) {
    debugPrint('Erro ao buscar medicamentos: $e');
  }
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
          title : const Text('Atualizar Quantidade'),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Nova quantidade',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                 context.go('/estoque');
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                int novaQuantidade = int.parse(_controller.text);
                _updateMedicamento(id, novaQuantidade); // Atualiza a quantidade
                context.go('/estoque');
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ESTOQUE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: medicamentos.isEmpty
            ? Center(child: Text('Nenhum medicamento encontrado.')) // Mensagem se não houver medicamentos
            : ListView.builder(
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
      );
  }
}

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
            ),
          ],
        ),
      ),
    );
  }
}