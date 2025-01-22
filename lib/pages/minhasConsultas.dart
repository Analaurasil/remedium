import 'package:flutter/material.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/consulta.dart';

class MinhasConsultas extends StatefulWidget {
  @override
  _MinhasConsultasState createState() => _MinhasConsultasState();
}

class _MinhasConsultasState extends State<MinhasConsultas> {
  List<Consulta> consultasList = []; // Lista para armazenar as consultas

  @override
  void initState() {
    super.initState();
    _fetchConsultas(); // Chama o método para buscar consultas ao iniciar
  }

  Future<void> _fetchConsultas() async {
    final db = DBHelper(); // Instância do seu DBHelper
    List<Consulta> consultas = await db.getConsultasForDate(DateTime.now()); // Método para buscar consultas
    setState(() {
      consultasList = consultas; // Atualiza a lista de consultas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Consultas'),
      ),
      body: consultasList.isEmpty
          ? Center(child: CircularProgressIndicator()) // Exibe um carregando enquanto busca as consultas
          : ListView.builder(
              itemCount: consultasList.length,
              itemBuilder: (context, index) {
                final consulta = consultasList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(consulta.titulo),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Médico: ${consulta.medico}'),
                        Text('Clínica: ${consulta.clinica}'),
                        Text('Horário: ${consulta.horario}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
/*
SEM CORREÇÕES
import 'package:flutter/material.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/consulta.dart'; 


class MinhasConsultas extends StatefulWidget {
  @override
  _MinhasConsultasState createState() => _MinhasConsultasState();
  }

class _MinhasConsultasState extends State<MinhasConsultas> {
  String consultasFuturas = '';
  String historicoConsultas = '';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //Adicionar aqui a lógica para voltar para a pagina inicial
            Navigator.pop(context);
          },
        ),
        title: Text(
              'Minhas Consultas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
          )
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<String>(
              // Configurações
              value: consultasFuturas,
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
                consultasFuturas 
            = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Three'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(), 
            ),
            DropdownButton<String>(
              // Configurações
              value: historicoConsultas,
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
                historicoConsultas
            = newValue!;
                });
              },
              items: <String>['One', 'Two', 'Three'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(), 
            )
          ],
        ),
      ),
    );
  }
}*/
