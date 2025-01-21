import 'package:flutter/material.dart';

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
}
