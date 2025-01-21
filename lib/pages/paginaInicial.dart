import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:remedium/temas.dart';


class TelaInicial extends StatefulWidget{
  const TelaInicial({super.key});

   @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/Logo.png'),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text(
                      'Login', 
                    ),
                  ),
                ),
            ],
          ),
          ),
      ),
    );
  }
}