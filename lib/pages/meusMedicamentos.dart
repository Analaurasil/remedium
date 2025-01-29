import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remedium25/db_helper.dart';
import 'package:remedium25/model/medicamento.dart'; 

class MeusMedicamentos extends StatefulWidget {
  @override
  _MeusMedicamentosState createState() => _MeusMedicamentosState();
}

class _MeusMedicamentosState extends State<MeusMedicamentos> {
  List<Medicamento> medicamentosList = []; 

  @override
  void initState() {
    super.initState();
    _fetchMedicamentos(); 
  }

  Future<void> _fetchMedicamentos() async {
    try{
    final db = DBHelper(); 
    List<Medicamento> medicamentos = await db.getMedicamentos(); 
    setState(() {
      medicamentosList = medicamentos; 
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
        title: Text(
          'Meus Medicamentos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: medicamentosList.isEmpty
          ? Center(child: CircularProgressIndicator()) 
          : ListView.builder(
              itemCount: medicamentosList.length,
              itemBuilder: (context, index) {
                final medicamento = medicamentosList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(medicamento.nomeMedicamento),
                    subtitle: Text('Dosagem: ${medicamento.dosagem}\nLaboratório: ${medicamento.laboratorio}'),
                  ),
                );
              },
            ),
    );
  }
}