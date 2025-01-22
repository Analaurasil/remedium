import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa a biblioteca intl para formatação
import 'package:go_router/go_router.dart';
import '/db_helper.dart'; // Importe seu DBHelper

class TelaAddConsulta extends StatefulWidget {
  const TelaAddConsulta({Key? key}) : super(key: key);

  @override
  _TelaAddConsultaState createState() => _TelaAddConsultaState();
}

class _TelaAddConsultaState extends State<TelaAddConsulta> {
  final _tituloController = TextEditingController();
  final _medicoController = TextEditingController();
  final _clinicaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _dataController = TextEditingController(); // Para a data
  bool _alarmeAtivo = false; // Variável para controlar o estado do alarme

  void _adicionarConsulta() async {
    if (_tituloController.text.isEmpty || _medicoController.text.isEmpty || 
        _clinicaController.text.isEmpty || _enderecoController.text.isEmpty || 
        _horarioController.text.isEmpty || _dataController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      // Formata a data e o horário
      String dataFormatada = _dataController.text; // Espera o formato DD/MM/YYYY
      String horarioFormatado = _horarioController.text; // Espera o formato HH:mm

      // Converte a string da data e horário para DateTime
      DateTime dataHora = DateFormat('dd/MM/yyyy HH:mm').parse('$dataFormatada $horarioFormatado');

      await DBHelper().insertConsulta(
        _tituloController.text,
        dataHora, // Passando o DateTime
        _medicoController.text,
        _clinicaController.text,
        _enderecoController.text,
        horarioFormatado, // Certifique-se de que o horário está no formato correto
        _alarmeAtivo, // Passando o estado do alarme
      );

      // Navegue de volta ou mostre uma mensagem de sucesso
      context.go('/homepage');
    } catch (e) {
      // Trate erros de conversão ou inserção
      debugPrint('Error adding consulta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar consulta: $e')),
      );
    }
  }

  Future<void> _selecionarHorario() async {
    TimeOfDay? horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horarioSelecionado != null) {
      String horarioFormatado = horarioSelecionado.format(context);
      _horarioController.text = horarioFormatado; // Atualiza o campo de texto
    }
  }

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataSelecionada != null) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(dataSelecionada); // Formata a data
      _dataController.text = dataFormatada; // Atualiza o campo de texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _medicoController,
              decoration: const InputDecoration(labelText: 'Médico'),
            ),
            TextField(
              controller: _clinicaController,
              decoration: const InputDecoration(labelText: 'Clínica'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            GestureDetector(
              onTap: _selecionarHorario, // Abre o seletor de horário ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _horarioController,
                  decoration: const InputDecoration(labelText: 'Horário'),
                ),
              ),
            ),
            GestureDetector(
              onTap: _selecionarData, // Abre o seletor de data ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _dataController,
                  decoration: const InputDecoration(labelText: 'Data (DD/MM/YYYY)'), // Formato esperado
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Adicionando o Switch para ativar/desativar o alarme
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ativar Alarme'),
                Switch(
                  value: _alarmeAtivo,
                  onChanged: (value) {
                    setState(() {
                      _alarmeAtivo = value; // Atualiza o estado do alarme
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConsulta,
              child: const Text('Adicionar Consulta'),
            ),
          ],
        ),
      ),
    );
  }
}
/*
ANTES DO SWITH E DE FUNCIONAR A INSERÇÃO
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa a biblioteca intl para formatação
import 'package:go_router/go_router.dart';
import '/db_helper.dart'; // Importe seu DBHelper

class TelaAddConsulta extends StatefulWidget {
  const TelaAddConsulta({Key? key}) : super(key: key);

  @override
  _TelaAddConsultaState createState() => _TelaAddConsultaState();
}

class _TelaAddConsultaState extends State<TelaAddConsulta> {
  final _tituloController = TextEditingController();
  final _medicoController = TextEditingController();
  final _clinicaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _dataController = TextEditingController(); // Para a data

  void _adicionarConsulta() async {
    if (_tituloController.text.isEmpty || _medicoController.text.isEmpty || 
        _clinicaController.text.isEmpty || _enderecoController.text.isEmpty || 
        _horarioController.text.isEmpty || _dataController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      // Formata a data e o horário
      String dataFormatada = _dataController.text; // Espera o formato DD/MM/YYYY
      String horarioFormatado = _horarioController.text; // Espera o formato HH:mm

      // Converte a string da data e horário para DateTime
      DateTime dataHora = DateFormat('dd/MM/yyyy HH:mm').parse('$dataFormatada $horarioFormatado');

      await DBHelper().insertConsulta(
        _tituloController.text,
        dataHora, // Passando o DateTime
        _medicoController.text,
        _clinicaController.text,
        _enderecoController.text,
        horarioFormatado, // Certifique-se de que o horário está no formato correto
      );

      // Navegue de volta ou mostre uma mensagem de sucesso
      context.go('/homepage');
    } catch (e) {
      // Trate erros de conversão ou inserção
      debugPrint('Error adding consulta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar consulta: $e')),
      );
    }
  }

  Future<void> _selecionarHorario() async {
    TimeOfDay? horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horarioSelecionado != null) {
      String horarioFormatado = horarioSelecionado.format(context);
      _horarioController.text = horarioFormatado; // Atualiza o campo de texto
    }
  }

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataSelecionada != null) {
      String dataFormatada = DateFormat('dd/MM/yyyy').format(dataSelecionada); // Formata a data
      _dataController.text = dataFormatada; // Atualiza o campo de texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _medicoController,
              decoration: const InputDecoration(labelText: 'Médico'),
            ),
            TextField(
              controller: _clinicaController,
              decoration: const InputDecoration(labelText: 'Clínica'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            GestureDetector(
              onTap: _selecionarHorario, // Abre o seletor de horário ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child : TextField(
                  controller: _horarioController,
                  decoration: const InputDecoration(labelText: 'Horário'),
                ),
              ),
            ),
            GestureDetector(
              onTap: _selecionarData, // Abre o seletor de data ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _dataController,
                  decoration: const InputDecoration(labelText: 'Data (DD/MM/YYYY)'), // Formato esperado
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConsulta,
              child: const Text('Adicionar Consulta'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
AJUSTES FINAIS - ANTES
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/db_helper.dart'; // Importe seu DBHelper

class TelaAddConsulta extends StatefulWidget {
  const TelaAddConsulta({Key? key}) : super(key: key);

  @override
  _TelaAddConsultaState createState() => _TelaAddConsultaState();
}

class _TelaAddConsultaState extends State<TelaAddConsulta> {
  final _tituloController = TextEditingController();
  final _medicoController = TextEditingController();
  final _clinicaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _dataController = TextEditingController(); // Para a data

  void _adicionarConsulta() async {
    if (_tituloController.text.isEmpty || _medicoController.text.isEmpty || 
        _clinicaController.text.isEmpty || _enderecoController.text.isEmpty || 
        _horarioController.text.isEmpty || _dataController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      // Converta a string da data e horário para DateTime
      DateTime dataHora = DateTime.parse('${_dataController.text} ${_horarioController.text}');

      await DBHelper().insertConsulta(
        _tituloController.text,
        dataHora, // Passando o DateTime
        _medicoController.text,
        _clinicaController.text,
        _enderecoController.text,
        _horarioController.text, // Certifique-se de que o horário está no formato correto
      );

      // Navegue de volta ou mostre uma mensagem de sucesso
      context.go('/homepage');
    } catch (e) {
      // Trate erros de conversão ou inserção
      debugPrint('Error adding consulta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar consulta: $e')),
      );
    }
  }

  Future<void> _selecionarHorario() async {
    TimeOfDay? horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horarioSelecionado != null) {
      String horarioFormatado = horarioSelecionado.format(context);
      _horarioController.text = horarioFormatado; // Atualiza o campo de texto
    }
  }

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataSelecionada != null) {
      String dataFormatada = "${dataSelecionada.toLocal()}".split(' ')[0]; // Formata a data para YYYY-MM-DD
      _dataController.text = dataFormatada; // Atualiza o campo de texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _medicoController,
              decoration: const InputDecoration(labelText: 'Médico'),
            ),
            TextField(
              controller: _clinicaController,
              decoration: const InputDecoration(labelText: 'Clínica'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            GestureDetector(
              onTap: _selecionarHorario, // Abre o seletor de horário ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _horarioController,
                  decoration: const InputDecoration(labelText: 'Horário'),
                ),
              ),
            ),
            GestureDetector(
              onTap: _selecionarData, // Abre o seletor de data ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _dataController,
                  decoration: const InputDecoration(labelText: 'Data (YYYY-MM-DD)'), // Formato esperado
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConsulta,
              child: const Text('Adicionar Consulta'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*
ANTES DOS AJUSTES DE EXIBIÇÃO 
import 'package:flutter/material.dart';
import '/db_helper.dart'; // Importe seu DBHelper

class TelaAddConsulta extends StatefulWidget {
  const TelaAddConsulta({Key? key}) : super(key: key);

  @override
  _TelaAddConsultaState createState() => _TelaAddConsultaState();
}

class _TelaAddConsultaState extends State<TelaAddConsulta> {
  final _tituloController = TextEditingController();
  final _medicoController = TextEditingController();
  final _clinicaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _horarioController = TextEditingController();
  final _dataController = TextEditingController(); // Para a data

  void _adicionarConsulta() async {
    if (_tituloController.text.isEmpty || _medicoController.text.isEmpty || 
        _clinicaController.text.isEmpty || _enderecoController.text.isEmpty || 
        _horarioController.text.isEmpty || _dataController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    try {
      // Converta a string da data e horário para DateTime
      DateTime dataHora = DateTime.parse('${_dataController.text} ${_horarioController.text}');

      await DBHelper().insertConsulta(
        _tituloController.text,
        dataHora, // Passando o DateTime
        _medicoController.text,
        _clinicaController.text,
        _enderecoController.text,
        _horarioController.text, // Certifique-se de que o horário está no formato correto
      );

      // Navegue de volta ou mostre uma mensagem de sucesso
      Navigator.pop(context);
    } catch (e) {
      // Trate erros de conversão ou inserção
      debugPrint('Error adding consulta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar consulta: $e')),
      );
    }
  }

  Future<void> _selecionarHorario() async {
    TimeOfDay? horarioSelecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horarioSelecionado != null) {
      String horarioFormatado = horarioSelecionado.format(context);
      _horarioController.text = horarioFormatado; // Atualiza o campo de texto
    }
  }

  Future<void> _selecionarData() async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataSelecionada != null) {
      String dataFormatada = "${dataSelecionada.toLocal()}".split(' ')[0]; // Formata a data para YYYY-MM-DD
      _dataController.text = dataFormatada; // Atualiza o campo de texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Consulta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _medicoController,
              decoration: const InputDecoration(labelText: 'Médico'),
            ),
            TextField(
              controller: _clinicaController,
              decoration: const InputDecoration(labelText: 'Clínica'),
            ),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            GestureDetector(
              onTap: _selecionarHorario, // Abre o seletor de horário ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _horarioController,
                  decoration: const InputDecoration(labelText: 'Horário'),
                ),
              ),
            ),
            GestureDetector(
              onTap: _selecionarData, // Abre o seletor de data ao tocar
              child: AbsorbPointer( // Impede a edição direta do campo
                child: TextField(
                  controller: _dataController,
                  decoration: const InputDecoration(labelText: 'Data (YYYY-MM-DD)'), // Formato esperado
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConsulta,
              child: const Text('Adicionar Consulta'),
            ),
          ],
        ),
      ),
    );
  }
}*/
/*import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';
import '/temas.dart';
import '/model/consulta.dart'; // Importe a classe Consulta
import '/db_helper.dart'; // Importe o DBHelper

class TelaAddConsulta extends StatefulWidget {
  const TelaAddConsulta({super.key});

  @override
  _TelaAddConsultaState createState() => _TelaAddConsultaState();
}

class _TelaAddConsultaState extends State<TelaAddConsulta> {
  final _tituloController = TextEditingController();
  final _medicoController = TextEditingController();
  final _clinicaController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _horarioController = TextEditingController();
  String _idCalendario = ''; // Defina como necessário

  void _adicionarConsulta() async {
    
    final consulta = Consulta(
      titulo: _tituloController.text,
      idCalendario: _idCalendario,
      medico: _medicoController.text,
      clinica: _clinicaController.text,
      endereco: _enderecoController.text,
      horario: _horarioController.text,
    );

    await DBHelper().insertConsulta(
      consulta.titulo,
      consulta.idCalendario,
      consulta.medico,
      consulta.clinica,
      consulta.endereco,
      consulta.horario,
    );

    // Navegue de volta ou mostre uma mensagem de sucesso
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Adicionar Consulta',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Theme(
        data: Temas.botoes,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: _medicoController,
                decoration: InputDecoration(labelText: 'Médico'),
              ),
              TextField(
                controller: _clinicaController,
                decoration: InputDecoration(labelText: 'Clínica'),
              ),
              TextField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço'),
              ),
              TextField(
                controller: _horarioController,
                decoration: InputDecoration(labelText: 'Horário'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _adicionarConsulta,
                child: Text('Adicionar Consulta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/





/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '/temas.dart';
import '/db_helper.dart';

Future<void> _insertConsulta(Consulta consulta) async {
  final db = await DBHelper.getInstance();
  await db.insert('consulta', consulta.toMap());
}

class Consulta{
  final int? id;
  final String titulo;
  final String idCalendario;
  final String medico;
  final String clinica;
  final String endereco;
  final String horario;

  Consulta({
    this.id,
    required this.titulo,
    required this.idCalendario,
    required this.medico,
    required this.clinica,
    required this.endereco,
    required this.horario
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'titulo': titulo,
      'idCalendario': idCalendario,
      'medico': medico,
      'clinica': clinica,
      'endereco': endereco,
      'horario': horario,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map){
    return Consulta(
      id: map['id'],
      titulo: map['titulo'], 
      idCalendario: map['idCalendario'], 
      medico: map['medico'], 
      clinica: map['clinica'], 
      endereco: map['endereco'], 
      horario: map['horario'],
    );
  }
}
class TelaAddConsulta extends StatelessWidget {
  const TelaAddConsulta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Temas.temaGeral,
        home: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  //Adicionar aqui a lógica para voltar para a anterior
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Adicionar Consultas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
          body: const FormAddConsulta(),
        ));
  }
}

class FormAddConsulta extends StatefulWidget {
  const FormAddConsulta({super.key});

  @override
  FormAddConsultaState createState() {
    return FormAddConsultaState();
  }
}

class FormAddConsultaState extends State<FormAddConsulta> {
  final _formKey = GlobalKey<FormState>();
  String data = '';
  String horario = '';
  String clinica = '';
  String medico = '';
  String endereco = '';
  bool alarme = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Data (DD/MM/AAAA)'),
                validator: (value) {
                  // Validação da data
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data';
                  }
                  // Faz a verificação do formato DD/MM/AAAA
                  final formatter = DateFormat('dd/MM/yyyy');
                  try {
                    formatter.parse(value);
                  } catch (e) {
                    return 'Formato de data inválido';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    data = value;
                  });
                },
              ),
              // Campo de hora
              TextFormField(
                decoration: InputDecoration(labelText: 'Horário'),
                // Falta tratamento e validação
                onChanged: (value) {
                  setState(() {
                    horario = value;
                  });
                },
              ),
            ],
          ),
          // Campo de clínica
          TextFormField(
            decoration: InputDecoration(labelText: 'Clínica'),
            onChanged: (value) {
              setState(() {
                clinica = value;
              });
            },
          ),

          // Campo de médico
          TextFormField(
            decoration: InputDecoration(labelText: 'Médico'),
            onChanged: (value) {
              setState(() {
                medico = value;
              });
            },
          ),

          // Campo de endereço
          TextFormField(
            decoration: InputDecoration(labelText: 'Endereço'),
            onChanged: (value) {
              setState(() {
                endereco = value;
              });
            },
            maxLines: null, // Permite múltiplas linhas para o endereço
          ),

          SwitchListTile(
            title: Text('Ativar Alarme'),
            value: alarme,
            onChanged: (value) {
              setState(() {
                alarme = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    _formKey.currentState!.save();

                    Consulta consulta = Consulta(
                      titulo: 'Insria o titulo aqui ', 
                      idCalendario: 'Insira o ID', 
                      medico: medico, 
                      clinica: clinica, 
                      endereco: endereco, 
                      horario: horario
                    );
                    try{
                      await _insertConsulta(consulta);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Consulta adicionada com sucesso!'))
                      );
                    context.go('/homepage');
                    } catch (e) {
                      print('Erro ao inserir a consulta: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erro ao adicionar consulta'))
                      );
                    }
                  }
                },
                child: Text('Concluir'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para cancelar o formulário e voltar para homepage
                context.go('/homepage');
                },
                child: Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/