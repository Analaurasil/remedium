
import 'package:flutter/material.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/medicamento.dart';
import 'package:remedium25/model/consulta.dart'; // Certifique-se de importar o modelo de consulta

class TelaAlarmes extends StatefulWidget {
  @override
  _TelaAlarmesState createState() => _TelaAlarmesState();
}

class _TelaAlarmesState extends State<TelaAlarmes> {
  List<Medicamento> medicamentosList = []; // Lista para armazenar os medicamentos
  List<Consulta> consultasList = []; // Lista para armazenar as consultas

  @override
  void initState() {
    super.initState();
    _fetchMedicamentos(); // Chama o método para buscar medicamentos ao iniciar
    _fetchConsultas(); // Chama o método para buscar consultas ao iniciar
  }

  Future<void> _fetchMedicamentos() async {
    final db = DBHelper(); // Instância do seu DBHelper
    List<Medicamento> medicamentos = await db.getMedicamentos(); // Método para buscar medicamentos
    setState(() {
      medicamentosList = medicamentos; // Atualiza a lista de medicamentos
    });
  }

  Future<void> _fetchConsultas() async {
    final db = DBHelper(); // Instância do seu DBHelper
    List<Consulta> consultas = await db.getConsultas(); // Método para buscar consultas
    setState(() {
      consultasList = consultas; // Atualiza a lista de consultas
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarmes'),
      ),
      body: ListView(
        children: [
          // Exibir medicamentos
          medicamentosList.isEmpty
              ? Center(child: CircularProgressIndicator()) // Exibe um carregando enquanto busca os medicamentos
              : Column(
                  children: medicamentosList.map((medicamento) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(medicamento.nomeMedicamento),
                        subtitle: Text('Horário: ${medicamento.horario}'),
                        trailing: Switch(
                          value: medicamento.alarmActive, // Supondo que você tenha um campo para o estado do alarme
                          onChanged: (bool value) {
                            setState(() {
                              medicamento.alarmActive = value; // Atualiza o estado do alarme
                              // Aqui você pode adicionar lógica para ativar/desativar o alarme
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
          // Exibir consultas
          consultasList.isEmpty
              ? Center(child: CircularProgressIndicator()) // Exibe um carregando enquanto busca as consultas
              : Column(
                  children: consultasList.map((consulta) {
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(consulta.titulo),
                        subtitle: Text('Médico: ${consulta.medico}'),
                        trailing: Switch(
                          value: consulta.alarmActive == 1, // Supondo que você tenha um campo para o estado do alarme
                          onChanged: (bool value) {
                            setState(() {
                              consulta.alarmActive = value; // Atualiza o estado do alarme
                              // Aqui você pode adicionar lógica para ativar/desativar o alarme
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
/*
EXIBINDO SOMENTE OS ALARMES DE MEDICAMENTOS 
import 'package:flutter/material.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/medicamento.dart';

class TelaAlarmes extends StatefulWidget {
  @override
  _TelaAlarmesState createState() => _TelaAlarmesState();
}

class _TelaAlarmesState extends State<TelaAlarmes> {
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
        title: const Text('Alarmes'),
      ),
      body: medicamentosList.isEmpty
          ? Center(child: CircularProgressIndicator()) // Exibe um carregando enquanto busca os medicamentos
          : ListView.builder(
              itemCount: medicamentosList.length,
              itemBuilder: (context, index) {
                final medicamento = medicamentosList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(medicamento.nomeMedicamento),
                    subtitle: Text('Horário: ${medicamento.horario}'),
                    trailing: Switch(
                      value: medicamento.alarmActive, // Supondo que você tenha um campo para o estado do alarme
                      onChanged: (bool value) {
                        setState(() {
                          medicamento.alarmActive = value; // Atualiza o estado do alarme
                          // Aqui você pode adicionar lógica para ativar/desativar o alarme
                        });
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}*/