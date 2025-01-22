import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/db_helper.dart';

class TelaAddMedicamentoManualmente extends StatefulWidget {
  const TelaAddMedicamentoManualmente({Key? key}) : super(key: key);

  @override
  _TelaAddMedicamentoManualmenteState createState() => _TelaAddMedicamentoManualmenteState();
}

class _TelaAddMedicamentoManualmenteState extends State<TelaAddMedicamentoManualmente> {
  final _nomeMedicamentoController = TextEditingController();
  final _laboratorioController = TextEditingController();
  final _idCalendarioController = TextEditingController();
  final _dosagemController = TextEditingController();
  final _posologiaController = TextEditingController();
  final _horarioController = TextEditingController();
  final _tempoTratamentoController = TextEditingController();
  final _inicioTratamentoController = TextEditingController();
  final _fimTratamentoController = TextEditingController();
  int _quantidade = 0;// Usar um inteiro para controlar a quantidade
  bool _alarmeAtivo = false;

  void _limparCampos() {
    _nomeMedicamentoController.clear();
    _laboratorioController.clear();
    _idCalendarioController.clear();
    _dosagemController.clear();
    _posologiaController.clear();
    _horarioController.clear();
    _tempoTratamentoController.clear();
    _inicioTratamentoController.clear();
    _fimTratamentoController.clear();
    _quantidade = 0; // Resetar a quantidade
     _alarmeAtivo = false;
  }

  Future<void> _inserirMedicamento() async {
    final nomeMedicamento = _nomeMedicamentoController.text.trim();
    final laboratorio = _laboratorioController.text.trim();
    final idCalendario = DateTime.tryParse(_idCalendarioController.text.trim()) ?? DateTime.now();
    final dosagem = _dosagemController.text.trim();
    final posologia = _posologiaController.text.trim();
    final horario = _horarioController.text.trim();
    final tempoTratamento = _tempoTratamentoController.text.trim();
    final inicioTratamento = DateTime.tryParse(_inicioTratamentoController.text.trim())?.toIso8601String() ?? DateTime.now().toIso8601String();
    final fimTratamento = DateTime.tryParse(_fimTratamentoController.text.trim())?.toIso8601String() ?? DateTime.now().toIso8601String();

    if (nomeMedicamento.isEmpty || laboratorio.isEmpty || 
        dosagem.isEmpty || posologia.isEmpty || horario.isEmpty || 
        tempoTratamento.isEmpty || _quantidade <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')),
      );
      return;
    }

    try {
      final db = DBHelper();
      await db.insertMedicamento(
        nomeMedicamento,
        laboratorio,
        idCalendario,
        dosagem,
        posologia,
        horario,
        tempoTratamento,
        inicioTratamento,
        fimTratamento,
        _quantidade,
        _alarmeAtivo,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medicamento cadastrado com sucesso!')),
      );
      context.go('/homepage');
      _limparCampos();
    } catch (e) {
      debugPrint('Erro ao cadastrar medicamento: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar medicamento: $e')),
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
      _horarioController.text = horarioFormatado;
    }
  }

  Future<void> _selecionarData(TextEditingController controller) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dataSelecionada != null) {
      String dataFormatada = "${dataSelecionada.toLocal()}".split(' ')[0]; // Formata a data para YYYY-MM-DD
      controller.text = dataFormatada; // Atualiza o campo de texto
    }
  }

  void _incrementarQuantidade() {
    setState(() {
      _quantidade++;
    });
  }

  void _decrementarQuantidade() {
    setState(() {
      if (_quantidade > 0) {
        _quantidade--;
      }
    });
  }

  void _adicionarDezena() {
    setState(() {
      _quantidade += 10;
    });
  }

  void _adicionarTrinta() {
    setState(() {
      _quantidade += 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Medicamento',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomeMedicamentoController,
                decoration: const InputDecoration(labelText: 'Nome do Medicamento'),
              ),
              TextField(
                controller: _laboratorioController,
                decoration: const InputDecoration(labelText: 'Laboratório'),
              ),
              TextField(
                controller: _idCalendarioController,
                decoration: const InputDecoration(labelText: 'ID do Calendário'),
              ),
              TextField(
                controller: _dosagemController,
                decoration: const InputDecoration(labelText: 'Dosagem'),
              ),
              TextField(
                controller: _posologiaController,
                decoration: const InputDecoration(labelText: 'Posologia'),
              ),
              GestureDetector(
                onTap: _selecionarHorario,
                child: AbsorbPointer(
                  child: TextField(
                    controller: _horarioController,
                    decoration: const InputDecoration(labelText: 'Horário'),
                  ),
                ),
              ),
              TextField(
                controller: _tempoTratamentoController,
                decoration: const InputDecoration(labelText: 'Tempo de Tratamento'),
              ),
              GestureDetector(
                onTap: () => _selecionarData(_inicioTratamentoController), // Seleciona a data de início
                child: AbsorbPointer(
                  child: TextField(
                    controller: _inicioTratamentoController,
                    decoration: const InputDecoration(labelText: 'Início do Tratamento'),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selecionarData(_fimTratamentoController), // Seleciona a data de fim
                child: AbsorbPointer(
                  child: TextField(
                    controller: _fimTratamentoController,
                    decoration: const InputDecoration(labelText: 'Fim do Tratamento'),
                  ),
                ),
              ),
              // Campo de quantidade com botões
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _decrementarQuantidade,
                    child: const Text('-'),
                  ),
                  Text(
                    '$_quantidade',
                    style: const TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: _incrementarQuantidade,
                    child: const Text('+'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _adicionarDezena,
                    child: const Text('Adicionar 10'),
                  ),
                  ElevatedButton(
                    onPressed: _adicionarTrinta,
                    child: const Text('Adicionar 30'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ativar Alarme'),
                  Switch(
                    value: _alarmeAtivo, 
                    onChanged: (value){
                      setState(() {
                        _alarmeAtivo = value;
                      });
                    }
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _inserirMedicamento,
                child: const Text('Cadastrar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/db_helper.dart';

class TelaAddMedicamentoManualmente extends StatefulWidget {
  const TelaAddMedicamentoManualmente({Key? key}) : super(key: key);

  @override
  _TelaAddMedicamentoManualmenteState createState() => _TelaAddMedicamentoManualmenteState();
}

class _TelaAddMedicamentoManualmenteState extends State<TelaAddMedicamentoManualmente> {
  final _nomeMedicamentoController = TextEditingController();
  final _laboratorioController = TextEditingController();
  final _idCalendarioController = TextEditingController();
  final _dosagemController = TextEditingController();
  final _posologiaController = TextEditingController();
  final _horarioController = TextEditingController();
  final _tempoTratamentoController = TextEditingController();
  final _inicioTratamentoController = TextEditingController();
  final _fimTratamentoController = TextEditingController();
  final _quantidadeController = TextEditingController();

 
  void _limparCampos() {
    _nomeMedicamentoController.clear();
    _laboratorioController.clear();
    _idCalendarioController.clear();
    _dosagemController.clear();
    _posologiaController.clear();
    _horarioController.clear();
    _tempoTratamentoController.clear();
    _inicioTratamentoController.clear();
    _fimTratamentoController.clear();
    _quantidadeController.clear();
  }
 Future<void> _inserirMedicamento() async {
  final nomeMedicamento = _nomeMedicamentoController.text.trim();
  final laboratorio = _laboratorioController.text.trim();
  
  // Converta o idCalendario de String para DateTime
  final idCalendario = DateTime.tryParse(_idCalendarioController.text.trim()) ?? DateTime.now(); // Converte para DateTime
  final dosagem = _dosagemController.text.trim();
  final posologia = _posologiaController.text.trim();
  final horario = _horarioController.text.trim();
  final tempoTratamento = _tempoTratamentoController.text.trim();
  
  // Converta as strings de data para DateTime
  final inicioTratamento = DateTime.tryParse(_inicioTratamentoController.text.trim())?.toIso8601String() ?? DateTime.now().toIso8601String();
  final fimTratamento = DateTime.tryParse(_fimTratamentoController.text.trim())?.toIso8601String() ?? DateTime.now().toIso8601String();
  
  final quantidade = int.tryParse(_quantidadeController.text.trim()) ?? 0;

  // Validação dos campos
  if (nomeMedicamento.isEmpty || laboratorio.isEmpty || 
      dosagem.isEmpty || posologia.isEmpty || horario.isEmpty || 
      tempoTratamento.isEmpty || quantidade <= 0) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor, preencha todos os campos corretamente.')),
    );
    return;
  }

  try {
    final db = DBHelper();
    await db.insertMedicamento(
      nomeMedicamento,
      laboratorio,
      idCalendario, // Passando como DateTime
      dosagem,
      posologia,
      horario,
      tempoTratamento,
      inicioTratamento, // Passando como String
      fimTratamento, // Passando como String
      quantidade,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicamento cadastrado com sucesso!')),
    );
    context.go('/homepage');
    _limparCampos();
  } catch (e) {
    debugPrint('Erro ao cadastrar medicamento: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao cadastrar medicamento: $e')),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro de Medicamento',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomeMedicamentoController,
                decoration: const InputDecoration(labelText: 'Nome do Medicamento'),
              ),
              TextField(
                controller: _laboratorioController,
                decoration: const InputDecoration(labelText: 'Laboratório'),
              ),
              TextField(
                controller: _idCalendarioController,
                decoration: const InputDecoration(labelText: 'ID do Calendário'),
              ),
              TextField(
                controller: _dosagemController,
                decoration: const InputDecoration(labelText: 'Dosagem'),
              ),
              TextField(
                controller: _posologiaController,
                decoration: const InputDecoration(labelText: 'Posologia'),
              ),
              TextField(
                controller: _horarioController,
                decoration: const InputDecoration(labelText: 'Horário'),
              ),
              TextField(
                controller: _tempoTratamentoController,
                decoration: const InputDecoration(labelText: 'Tempo de Tratamento'),
              ),
              TextField(
                controller: _inicioTratamentoController,
                decoration: const InputDecoration(labelText: 'Início do Tratamento'),
              ),
              TextField(
                controller: _fimTratamentoController,
                decoration: const InputDecoration(labelText: 'Fim do Tratamento'),
              ),
              TextField(
                controller: _quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _inserirMedicamento,
                child: const Text('Cadastrar Medicamento'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/