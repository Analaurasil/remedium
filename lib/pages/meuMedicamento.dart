/*import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:remedium/db_helper.dart';
import 'package:remedium/temas.dart';*/

/*class Medicamento {
  final String nomeMedicamento;
  final String laboratorio;
  final String idCalendario;
  final String dosagem;
  final String posologia;
  final String horario;
  final String tempoTratamento;
  final String incioTratamento;
  final String fimTratamento;
  final int quantidade; //= 0;
  
   // final int quantidade;
  Medicamento({
   // Key? key,
    required this.nomeMedicamento,
    required this.laboratorio,
    required this.idCalendario,
    required this.dosagem,
    required this.posologia,
    required this.horario,
    required this.tempoTratamento,
    required this.incioTratamento,
    required this.fimTratamento,
    required this.quantidade,

  });
   Map<String, dynamic> toMap() {
    return {
      'nomeMedicamento': nomeMedicamento,
      'laboratorio': laboratorio,
      'idCalendario': idCalendario,
      'dosagem':dosagem,
      'posologia':posologia,
      'horario':horario,
      'tempoTratamento':tempoTratamento,
      'inicioTratamento':incioTratamento,
      'fimTratamento':fimTratamento,
      'quantidade': quantidade,
    };
  }
}

class MeuMedicamento extends StatefulWidget{
  final _formKey = GlobalKey<FormState>();
  
   @override
  _MeuMedicamentoState createState() => _MeuMedicamentoState();
}

class _MeuMedicamentoState extends State<MeuMedicamento> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String tipoUso = 'continuo';
  bool usarAlarme = false;
  void saveMedicamento() async {
    final medicamento = Medicamento(
      nomeMedicamento: '', 
      laboratorio: '', 
      idCalendario: '', 
      dosagem: '', 
      posologia: '', 
      horario: '', 
      tempoTratamento: '', 
      incioTratamento: '', 
      fimTratamento: '', 
      quantidade: 0, 
    );
    final db = await DBHelper.getInstance();
    await db.insert('medicamento', medicamento.toMap());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final medicamentoProvider = Provider.of<MedicamentoProvider>(context);
    return MaterialApp(
    theme: Temas.temaGeral,
    home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            //Adicionar aqui a lógica para voltar para a pagina inicial
            Navigator.pop(context);
          },
        ),
        title: Text(
              'Meu Medicamento',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
          )
      ),
      body: Form(
        key: _formKey,
        child: Column(
           children: [
           /* Para implementação quando for feita a opção de busca ou escanear
            MedicamentoCard(
                nome: '',
                quantidade: 1,
                laboratorio: '',
                dosagem: '',
              ),*/
            TextField(
              /*onChanged: (value) {
              },*/
              decoration: InputDecoration(
                labelText: 'Posologia',
              ),
            ),
            DropdownButtonFormField<String>(
              value: tipoUso,
              onChanged: (newValue) {
                setState(() {
                  tipoUso = newValue!;
                });
              },
              items: ['continuo', 'intervalos', 'unico']
                  .map((tipo) => DropdownMenuItem(
                        value: tipo,
                        child: Text(tipo),
                      ))
                  .toList(),
            ),
            //DateRangePicker(),
            //usar Use um ListView.builder para adicionar campos de horário dinamicamente com base no tipoUso.
           //Use o pacote flutter_datetime_picker para criar um calendário personalizado.
           Switch(
              value: usarAlarme,
              onChanged: (value) {
                setState(() {
                  usarAlarme = value;
                });
              },
            ),
             ElevatedButton(
                    onPressed:() async {
                      if (_formKey.currentState!.validate){
                        await saveMedicamento();   
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Medicamento salvo com sucesso!'))
                        );
                      }
                    }, 
                    child: Text('Concluir'),
                  ),
            ElevatedButton(
                    onPressed:() {
                      context.go('/homepage');
                    }, 
                    child: Text('Cancelar'),
                  )
          ],
        )
      )
      )
    );
  }
}

class MedicamentoCard extends StatelessWidget {
  final String nome;
  final int quantidade;
  final String laboratorio;
  final String dosagem;

  const MedicamentoCard({
    Key? key,
    required this.nome,
    required this.quantidade,
    required this.laboratorio,
    required this.dosagem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( 
              '$nome ($quantidade)',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Laboratório: $laboratorio'),
            Text('Dosagem: $dosagem'),
          ],
        ),
      ),
    );
  }
}*/

/*class MedicamentoModel {
  final String nome;
  final int quantidade;
  // ... outros dados 
}

class MinhaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final medicamento = Provider.of<MedicamentoModel>(context);
    return Scaffold(
      // ...
      body: Center(
        child: MedicamentoCard(
          nome: medicamento.nome,
          quantidade: medicamento.quantidade,
          // ...
        ),
      ),
    );
  }
}*/