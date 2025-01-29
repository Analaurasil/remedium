import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/consulta.dart';

class MinhasConsultas extends StatefulWidget {
  @override
  _MinhasConsultasState createState() => _MinhasConsultasState();
}

class _MinhasConsultasState extends State<MinhasConsultas> {
  List<Consulta> consultasList = []; 

  @override
  void initState() {
    super.initState();
    _fetchConsultas(); 
  }

  Future<void> _fetchConsultas() async {
    try{
    final db = DBHelper(); 
    List<Consulta> consultas = await db.getConsultas(); 
    setState(() {
      consultasList = consultas; 
    });
    } catch (e){
      debugPrint('Erro ao retornar consultas: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/menu'); 
          },
        ),
        title: const Text(
          'Minhas Consultas',
          style: TextStyle(fontSize: 18),
          ),
      ),
      body: consultasList.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : consultasList.isEmpty
          ? Center(child: Text('Nenhuma consulta encontrada.'))
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