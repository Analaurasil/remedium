
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remedium25/temas.dart';

class MenuUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Temas.temaGeral,
      home: Scaffold(
        /*appBar: AppBar(
          title: Text('Menu'),
        ),*/
        body: Center(
          child: Column(
            mainAxisAlignment: 
              MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  context.go('/homepage'); 
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/editarPerfil');
                },
                child: Text('Editar Perfil'),
              ),
              /*ElevatedButton(
                onPressed: () {
                  // Lógica 
                  context.go('/relatorio');
                },
                child: Text('Gerar Relatório'),
              ),*/
              ElevatedButton(
                onPressed: () {
                  context.go('/meusMedicamentos');
                },
                child: Text('Meus Medicamentos'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/minhasConsultas');
                },
                child: Text('Minhas Consultas'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para logout
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      )
    );
  }
}