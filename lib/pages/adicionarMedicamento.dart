import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import '/temas.dart';

class TelaAddMedicamento extends StatefulWidget {
  const TelaAddMedicamento({super.key});

  @override
  _TelaAddMedicamentoState createState() => _TelaAddMedicamentoState();
}

class _TelaAddMedicamentoState extends State<TelaAddMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Adicionar Medicamento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Theme(
        data: Temas.botoes,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                     context.go('/escanearMedicamento');
                  },
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text('Escanear Código de Barras'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.go('/buscarMedicamento');
                  },
                  icon: Icon(Icons.search),
                  label: Text('Buscar por Nome'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.go('/meuMedicamento');
                  },
                  icon: Icon(Icons.create),
                  label: Text('Inserir Manualmente'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}