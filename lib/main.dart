import 'package:flutter/material.dart';
import 'package:remedium25/routes.dart';
import 'package:remedium25/temas.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: configuraRouter(),
      //routerConfig: router, 
      debugShowCheckedModeBanner: false,
      title: 'Remedium',
      theme: Temas.temaGeral,
    );
  }
}