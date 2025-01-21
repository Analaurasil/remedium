import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Uncomment if using GoRouter
import '/temas.dart';

class TelaBuscarMedicamento extends StatefulWidget {
  const TelaBuscarMedicamento({super.key});

  @override
  _TelaBuscarMedicamentoState createState() => _TelaBuscarMedicamentoState();
}

class _TelaBuscarMedicamentoState extends State<TelaBuscarMedicamento> {
  String _resultado = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Temas.temaGeral,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              // Add logic to navigate back to the initial page if needed
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Buscar Medicamento',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        body: Column(
          children: [
            const Text(
              'Digite o nome do medicamento:',
              style: TextStyle(
                color: Colors.black, // Adjust color as needed
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Digite sua pesquisa',
              ),
              onChanged: (value) {
                // Implement search logic here
                setState(() {
                  _resultado = 'Resultado da pesquisa: $value';
                });
              },
            ),
            const Divider(), // Line separator
            Text(_resultado),
            ElevatedButton(
                  onPressed:() {
                   context.go('/homepage');
                  }, 
                  child: Text('Cancelar'),
                )
          ],
        ),
      ),
    );
  }
}