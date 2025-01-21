import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:remedium25/db_helper.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _senhaVisivel = false; // Para controlar a visibilidade da senha

  Future<bool> _validaLogin(String email, String senha) async {
    final db = await DBHelper.getInstance();
    try {
      final resultado = await db.query(
        'usuario',
        where: 'email = ? AND senha = ?',
        whereArgs: [email, senha],
      );
      return resultado.isNotEmpty;
    } catch (e) {
      debugPrint('Erro ao validar login: $e');
      return false;
    }
  }

  void _efetuarLogin(String email, String senha) async {
    final validou = await _validaLogin(email, senha);
    if (validou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Efetuado com sucesso!'),
        ),
      );
      context.go('/homepage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ERRO! Email ou senha incorretos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/cadastro');
            },
            child: const Text(
              'CADASTRO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LOGIN',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _senhaController,
                obscureText: !_senhaVisivel, // Controla a visibilidade da senha
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _senhaVisivel ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _senhaVisivel = !_senhaVisivel; // Alterna a visibilidade
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _efetuarLogin(_emailController.text, _senhaController.text);
                  },
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import 'package:remedium/temas.dart';
import 'package:remedium25/db_helper.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  Future<bool> _validaLogin(String email, String senha) async {
    final db = await DBHelper.getInstance();
    try {
      final resultado = await db.query(
        'usuario',
        where: 'email = ? AND senha = ?',
        whereArgs: [email, senha],
      );
      return resultado.isNotEmpty;
    } catch (e) {
      debugPrint('Erro ao validar login: $e');
      return false;
    }
  }

  void _efetuarLogin(String email, String senha) async {
    final validou = await _validaLogin(email, senha);
    if (validou) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Efetuado com sucesso!'),
        ),
      );
      context.go('/homepage');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ERRO! Email ou senha incorretos'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/cadastro');
            },
            child: const Text(
              'CADASTRO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'LOGIN',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _efetuarLogin(_emailController.text, _senhaController.text);
                  },
                  child: const Text('Entrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/