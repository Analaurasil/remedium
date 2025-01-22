import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/db_helper.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _nomeController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  bool _senhaVisivel = false; 
  bool _confirmaSenhaVisivel = false; 

  @override
  void initState() {
    super.initState();
    _initializeDb();
  }

  Future<void> _initializeDb() async {
    try {
      await DBHelper.getInstance();
    } catch (error) {
      print('Error initializing database: $error');
    }
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  Future<void> _registraUsuario(
    String nomeUsuario,
    String dataNascimento,
    String email,
    String senha,
    String confirmaSenha,
  ) async {
    if (!_isEmailValid(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um email válido.')),
      );
      return;
    }

    if (senha != confirmaSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem.')),
      );
      return;
    }

    try {
      final db = DBHelper();
      await db.insertUsuario(nomeUsuario, dataNascimento, email, senha);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro Concluído!')),
      );
      context.go('/login');
    } catch (error) {
      debugPrint('Error registering user: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $error')),
      );
    }
  }

  Future<void> _selecionarDataNascimento() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      String dataFormatada = "${dataSelecionada.toLocal()}".split(' ')[0]; 
      _dataNascimentoController.text = dataFormatada; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/login');
          },
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'CADASTRO',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  labelText: 'Nome',
                  controller: _nomeController,
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: _selecionarDataNascimento, 
                  child: AbsorbPointer( 
                    child: _buildTextField(
                      labelText: 'Data de Nascimento',
                      controller: _dataNascimentoController,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                _buildTextField(
                  labelText: 'Email',
                  controller: _emailController,
                ),
                SizedBox(height: 16.0),
                _buildPasswordField(
                  labelText: 'Senha',
                  controller: _senhaController,
                  isVisible: _senhaVisivel,
                  onToggleVisibility: () {
                    setState(() {
                      _senhaVisivel = !_senhaVisivel;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                _buildPasswordField(
                  labelText: 'Confirme a senha',
                  controller: _confirmaSenhaController,
                  isVisible: _confirmaSenhaVisivel,
                  onToggleVisibility: () {
                    setState(() {
                      _confirmaSenhaVisivel = !_confirmaSenhaVisivel;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _registraUsuario(
                      _nomeController.text,
                      _dataNascimentoController.text,
                      _emailController.text,
                      _senhaController.text,
                      _confirmaSenhaController.text, 
                    ),
                    child: const Text('Cadastrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  Widget _buildPasswordField({
    required String labelText,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
    );
  }
}