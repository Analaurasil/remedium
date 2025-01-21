import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '/db_helper.dart'; // Importe seu DBHelper
import '/model/medicamento.dart'; // Importe a classe Medicamento
import '/model/consulta.dart'; // Importe a classe Consulta

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 1, now.day);
var lastDay = DateTime(now.year, now.month + 1, now.day);

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({Key? key}) : super(key: key);

  @override
  _TelaCalendarioState createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  CalendarFormat format = CalendarFormat.week; // Mude para exibir a semana
  DateTime selectedDay = now;
  List<Medicamento> medicamentos = [];
  List<Consulta> consultas = [];

  @override
  void initState() {
    super.initState();
    _loadEventsForSelectedDay(selectedDay);
  }

  void _loadEventsForSelectedDay(DateTime day) async {
    // Carregue medicamentos e consultas do banco de dados para a data selecionada
    final dbHelper = DBHelper();
    final medicamentosList = await dbHelper.getMedicamentosForDate(day); // Implemente este método
    final consultasList = await dbHelper.getConsultasForDate(day); // Implemente este método

    setState(() {
      medicamentos = medicamentosList;
      consultas = consultasList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: selectedDay,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableCalendarFormats: const {
            CalendarFormat.week: 'Semana', // Apenas formato semanal
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              _loadEventsForSelectedDay(selectedDay);
            });
          },
          headerStyle: HeaderStyle(
            leftChevronIcon: const Icon(Icons.keyboard_arrow_left, size: 24, color: Colors.black),
            rightChevronIcon: const Icon(Icons.keyboard_arrow_right, size: 24, color: Colors.black),
            headerPadding: EdgeInsets.zero,
            formatButtonVisible: false, // Desabilitar o botão de formato
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            selectedDecoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
            ),
            selectedTextStyle: const TextStyle(color: Color.fromRGBO(238, 230, 236, 1)),
            todayDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.rectangle,
            ),
            todayTextStyle: const TextStyle(color: Colors.blueGrey),
            defaultDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),
            defaultTextStyle: const TextStyle(color: Colors.blueGrey),
            weekendDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),
            weekendTextStyle: const TextStyle(color: Colors.blueGrey),
          ),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              String text;
              switch (day.weekday) {
                case DateTime.sunday:
                  text = 'dom';
                  break;
                case DateTime.monday:
                  text = 'seg';
                  break;
                case DateTime.tuesday:
                  text = 'ter';
                  break;
                case DateTime.wednesday:
                  text = 'qua';
                  break;
                case DateTime.thursday:
                  text = 'qui';
                  break;
                case DateTime.friday:
                  text = 'sex';
                  break;
                case DateTime.saturday:
                  text = 'sab';
                  break;
                default:
                  text = 'err';
              }
              return Center(
                child: Text(text, style: const TextStyle(color: Colors.blueGrey)),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: medicamentos.length + consultas.length,
            itemBuilder: (context, index) {
              if (index < medicamentos.length) {
                final medicamento = medicamentos[index];
                return ListTile(
                  title: Text(medicamento.nomeMedicamento),
                  subtitle: Text('Laboratório: ${medicamento.laboratorio}'),
                );
              } else {
                final consulta = consultas[index - medicamentos.length];
                return ListTile(
                  title: Text(consulta.titulo),
                  subtitle: Text('Médico: ${consulta.medico}'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
/*import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '/db_helper.dart'; // Importe seu DBHelper
import '/model/medicamento.dart'; // Importe a classe Medicamento
import '/model/consulta.dart'; // Importe a classe Consulta

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 1, now.day);
var lastDay = DateTime(now.year, now.month + 1, now.day);

class TelaCalendario extends StatefulWidget {
  const TelaCalendario({Key? key}) : super(key: key);

  @override
  _TelaCalendarioState createState() => _TelaCalendarioState();
}

class _TelaCalendarioState extends State<TelaCalendario> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = now;
  List<Medicamento> medicamentos = [];
  List<Consulta> consultas = [];

  @override
  void initState() {
    super.initState();
    _loadEventsForSelectedDay(selectedDay);
  }

  void _loadEventsForSelectedDay(DateTime day) async {
    // Carregue medicamentos e consultas do banco de dados para a data selecionada
    final dbHelper = DBHelper();
    final medicamentosList = await dbHelper.getMedicamentosForDate(day); // Implemente este método
    final consultasList = await dbHelper.getConsultasForDate(day); // Implemente este método

    setState(() {
      medicamentos = medicamentosList;
      consultas = consultasList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: selectedDay,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Mês',
            CalendarFormat.week: 'Semana',
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              _loadEventsForSelectedDay(selectedDay);
            });
          },
          headerStyle: HeaderStyle(
            leftChevronIcon: const Icon(Icons.keyboard_arrow_left, size: 24, color: Colors.black),
            rightChevronIcon: const Icon(Icons.keyboard_arrow_right, size: 24, color: Colors.black),
            headerPadding: EdgeInsets.zero,
            formatButtonVisible: true,
            formatButtonShowsNext: true,
            formatButtonDecoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
            ),
            formatButtonTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
            titleTextStyle: const TextStyle(color: Colors.blueGrey),
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            selectedDecoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.rectangle,
            ),
            selectedTextStyle: const TextStyle(color: Color.fromRGBO(238, 230, 236, 1)),
            todayDecoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.rectangle,
            ),
            todayTextStyle: const TextStyle(color: Colors.blueGrey),
            defaultDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),
            defaultTextStyle: const TextStyle(color: Colors.blueGrey),
            weekendDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),
            weekendTextStyle: const TextStyle(color: Colors.blueGrey),
          ),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              String text;
              switch (day.weekday) {
                case DateTime.sunday:
                  text = 'dom';
                  break;
                case DateTime.monday:
                  text = 'seg';
                  break;
                case DateTime.tuesday:
                  text = 'ter';
                  break;
                case DateTime.wednesday:
                  text = 'qua';
                  break;
                case DateTime.thursday:
                  text = 'qui';
                  break;
                case DateTime.friday:
                  text = 'sex';
                  break;
                case DateTime.saturday:
                  text = 'sab';
                  break;
                default:
                  text = 'err';
              }
              return Center(
                child: Text(text, style: const TextStyle(color: Colors.blueGrey)),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: medicamentos.length + consultas.length,
            itemBuilder: (context, index) {
              if (index < medicamentos.length) {
                final medicamento = medicamentos[index];
                return ListTile(
                  title: Text(medicamento.nomeMedicamento),
                  subtitle: Text('Laboratório: ${medicamento.laboratorio}'),
                );
              } else {
                final consulta = consultas[index - medicamentos.length];
                return ListTile(
                  title: Text(consulta.titulo),
                  subtitle: Text('Médico: ${consulta.medico}'),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}*/
/*import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 1, now.day);
var lastDay = DateTime(now.year, now.month + 1, now.day);

class TelaCalendario extends StatefulWidget{
  const TelaCalendario({ Key? key}) : super(key: key);

  @override
  _TelaCalendarioState createState() => _TelaCalendarioState();

}
class _TelaCalendarioState extends State<TelaCalendario>{

CalendarFormat format = CalendarFormat.week;

@override
  Widget build(BuildContext context){
    return Column(
      children: [
        TableCalendar(
          focusedDay: now,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableCalendarFormats: const{
          CalendarFormat.month: 'Mês',
          CalendarFormat.week: 'Semana',
          },

        headerStyle: HeaderStyle(
          leftChevronIcon: const Icon(Icons.keyboard_arrow_left, size: 24, color: Colors.black),
          rightChevronIcon: const Icon(Icons.keyboard_arrow_right, size: 24, color: Colors.black,),
          headerPadding: EdgeInsets.zero,
          formatButtonVisible: true,
          formatButtonShowsNext: true,
          formatButtonDecoration: BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15)
          ),
          formatButtonTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
          titleTextStyle: const TextStyle(color: Colors.blueGrey),
          titleCentered: true
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false, 
          selectedDecoration: const BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.rectangle
          ),
          selectedTextStyle: const TextStyle(color: Color.fromRGBO(238, 230, 236, 1)),
          todayDecoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.rectangle
          ),
          todayTextStyle: const TextStyle(color: Colors.blueGrey),

          defaultDecoration: const BoxDecoration(
            color: Colors.transparent, shape:BoxShape.rectangle
          ),
          defaultTextStyle: const TextStyle(color: Colors.blueGrey),

          weekendDecoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.rectangle),

          weekendTextStyle: const TextStyle(color: Colors.blueGrey)
        ),

        calendarBuilders: CalendarBuilders(
          dowBuilder: (context,day){
            String text;
            if(day.weekday == DateTime.sunday){
              text = 'dom';
            } else if(day.weekday == DateTime.monday){
              text='seg';
            }else if(day.weekday == DateTime.tuesday){
              text='ter';
            }else if(day.weekday == DateTime.wednesday){
              text='qua';
            }else if(day.weekday == DateTime.thursday){
              text='qui';
            }else if(day.weekday == DateTime.friday){
              text='sex';
            }else if(day.weekday == DateTime.monday){
              text='sab';
            }else {
              text = 'err';
            }
            return Center(
              child: Text(text, style: const TextStyle(color: Colors.blueGrey)),
            );
          }
        ),

        )
      ],
    );
 }
}*/