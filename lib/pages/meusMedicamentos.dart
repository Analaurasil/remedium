import 'package:flutter/material.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/medicamento.dart'; // Certifique-se de que a classe Medicamento está importada

class MeusMedicamentos extends StatefulWidget {
  @override
  _MeusMedicamentosState createState() => _MeusMedicamentosState();
}

class _MeusMedicamentosState extends State<MeusMedicamentos> {
  String? medicamentosEmUso;
  String? historicoMedicamentos;
  List<Medicamento> medicamentosList = []; // Lista para armazenar os medicamentos

  @override
  void initState() {
    super.initState();
    _fetchMedicamentos(); // Chama o método para buscar medicamentos ao iniciar
  }

  Future<void> _fetchMedicamentos() async {
    final db = DBHelper(); // Instância do seu DBHelper
    List<Medicamento> medicamentos = await db.getMedicamentos(); // Método para buscar medicamentos
    setState(() {
      medicamentosList = medicamentos; // Atualiza a lista de medicamentos
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context); // Volta para a página anterior
          },
        ),
        title: Text(
          'Meus Medicamentos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // Dropdown para medicamentos em uso
            DropdownButton<String>(
              value: medicamentosEmUso,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  medicamentosEmUso = newValue;
                });
              },
              items: medicamentosList.map<DropdownMenuItem<String>>((Medicamento medicamento) {
                return DropdownMenuItem<String>(
                  value: medicamento.nomeMedicamento, // Use o nome do medicamento como valor
                  child: Text(medicamento.nomeMedicamento), // Exibe o nome do medicamento
                );
              }).toList(),
            ),
            // Dropdown para histórico de medicamentos
            DropdownButton<String>(
              value: historicoMedicamentos,
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.blue),
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  historicoMedicamentos = newValue;
                });
              },
              items: medicamentosList.map<DropdownMenuItem<String>>((Medicamento medicamento) {
                return DropdownMenuItem<String>(
                  value: medicamento.nomeMedicamento, // Use o nome do medicamento como valor
                  child: Text(medicamento.nomeMedicamento), // Exibe o nome do medicamento
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}