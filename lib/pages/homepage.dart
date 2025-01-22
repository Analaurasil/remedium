import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/pages/calendario.dart';
import '/pages/estoque.dart';
import '/pages/alarmes.dart';
import '/temas.dart';
import '/pages/menu.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _itemSelecionado = 1;
  final List<Widget> _subtelas = [
    TelaAlarmes(), // Substitua por sua página de alarmes
    TelaCalendario(), // Substitua por sua página de calendário
    TelaEstoque(), // Substitua por sua página de estoque
  ];

  _showMenu(){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.medication_outlined),
                title: Text('Adicionar Medicamento'),
                onTap: () {
                  //caminho para pagina
                   context.go('/addMedicamentoManual');
                },
              ),
              ListTile(
                leading: Icon(Icons.event_available),
                title: Text('Adicionar Consulta'),
                onTap: () {
                  //caminho para pagina
                   context.go('/addConsulta');
                },
              )
            ],
          ),
        );
      }
    );
  }
  _menuDeNavegacao(){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => MenuUsuario()),
      );
  }
  @override
  Widget build(BuildContext context) {
   // var args =  ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {},
      child: Theme(
        data: Temas.temaGeral,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle_outlined),
                onPressed: _menuDeNavegacao
              ),
            ]
          ),
          body: Center(
            child: _subtelas[_itemSelecionado],

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showMenu,
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.blueAccent,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_outlined),
                label: 'Alarmes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_available),
                label: 'Calendário',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medication_outlined),
                label: 'Estoque',
              ),
            ],
            currentIndex: _itemSelecionado,
            onTap: (idx) {
              setState(() {
                if (idx == 2) {
                  Navigator.pop(context);
                }
                _itemSelecionado = idx;
              });
            },
          ),
        ),
      )
    );
  }
}
