import 'package:go_router/go_router.dart';
import 'package:remedium25/pages/adicionarMedicamento.dart';
import 'pages/addMedicamentoManual.dart';
import 'pages/adicionarConsulta.dart';
//import 'pages/adicionarMedicamento.dart';
import 'pages/buscarMedicamento.dart';
import 'pages/editarPerfil.dart';
//import 'pages/escanearMedicamentos.dart';
import 'pages/estoque.dart';
import 'pages/menu.dart';
//import 'pages/meuMedicamento.dart';
import 'pages/meusMedicamentos.dart';
import 'pages/minhasConsultas.dart';
//import 'pages/relatorio.dart';
import 'pages/paginaInicial.dart';
import 'pages/cadastro.dart';
import 'pages/login.dart';
import 'pages/homepage.dart';

final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TelaInicial(),
      ),
      GoRoute(
        path: '/cadastro',
        builder: (context, state) => const TelaCadastro(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const TelaLogin(),
      ),
       GoRoute(
        path: '/homepage',
        builder: (context, state) => const Homepage(),
      ),
      GoRoute(
        path: '/addMedicamento',
        builder: (context, state) => const TelaAddMedicamento(),
      ),
      /*GoRoute(
        path: '/escanearMedicamento',
       // builder: (context, state) => const TelaEscanarMedicamento(),
      ),*/
      GoRoute(
        path: '/buscarMedicamento',
        builder: (context, state) => const TelaBuscarMedicamento(),
      ),
      GoRoute(
        path: '/addConsulta',
        builder: (context, state) => const TelaAddConsulta(),
      ),

      GoRoute(
        path: '/editarPerfil',
        builder: (context, state) => TelaEditarPerfil(),
      ),
      GoRoute(
        path: '/estoque',
        builder: (context, state) => const TelaEstoque(),
      ),

      GoRoute(
        path: '/menu',
        builder: (context, state) => MenuUsuario(),
      ),

      /*GoRoute(
        path: '/meuMedicamento',
        builder: (context, state) => MeuMedicamento(),
      ),*/
      GoRoute(
        path: '/addMedicamentoManual',
      builder: (context, state) => TelaAddMedicamentoManualmente(),
      ),
      GoRoute(
        path: '/meusMedicamentos',
        builder: (context, state) => MeusMedicamentos(),
      ),

      GoRoute(
        path: '/minhasConsultas',
        builder: (context, state) => MinhasConsultas(),
      ),
      /*GoRoute(
        path: '/relatorio',
     // builder: (context, state) => const TelaRelatorio(),
      ),*/
    ],
  );
  
GoRouter configuraRouter() {
  return router;
}