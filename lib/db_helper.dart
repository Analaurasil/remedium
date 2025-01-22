import 'package:flutter/material.dart';
import '/model/medicamento.dart';
import '/model/consulta.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database _instance;
  static const String dbName = 'remedium.db';

  /*static Future<void> deleteDatabaseFile() async {
    String databasesPath = await getDatabasesPath();
    var path = databasesPath + dbName;
    await deleteDatabase(path); // Deleta o banco de dados existente
  }*/
  
  static Future<Database> getInstance() async {
    String databasesPath = await getDatabasesPath();
    var path = databasesPath + dbName;
    _instance = await openDatabase(path,
        version: 1,
        onCreate: _onCreate,
        onOpen: _onOpen,
        onUpgrade: _onUpgrade,
        onDowngrade: _onDowngrade);
    return _instance;
  }

  static Future<void> _onCreate(Database db, int version) async {
    debugPrint('Criando Tabelas');
    await db.execute(
        'CREATE TABLE  usuario (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, nomeUsuario TEXT, senha TEXT, dataNascimento TEXT)');
    await db.execute(
        'CREATE TABLE  tipo (id INTEGER PRIMARY KEY AUTOINCREMENT, valor TEXT, tabela TEXT)');
    await db.execute(
        'CREATE TABLE  calendario (id INTEGER PRIMARY KEY AUTOINCREMENT, dataHora TEXT, tipo TEXT)');
    await db.execute(
        'CREATE TABLE  medicamento (id INTEGER PRIMARY KEY AUTOINCREMENT, nomeMedicamento TEXT, laboratorio TEXT, idCalendario TEXT, dosagem TEXT, posologia TEXT, horario TEXT, tempoTratamento TEXT, incioTratamento TEXT, fimTratamento TEXT, quantidade NUMBER, alarmActive INTEGER DEFAULT 0, FOREIGN KEY (idCalendario) REFERENCES calendario(id))');
    await db.execute(
        'CREATE TABLE  consulta (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo TEXT, idCalendario TEXT, medico TEXT, clinica TEXT, endereco TEXT, horario TEXT, alarmActive INTEGER DEFAULT 0, FOREIGN KEY (idCalendario) REFERENCES calendario(id))');
  }

  static void _onOpen(Database db) async {
    debugPrint('Versao do banco:${await db.getVersion()}');
  }

  static void _onUpgrade(Database db, int oldV, int newV) async {
    debugPrint('Fazendo upgrade da versao $oldV para $newV');
  }

  static void _onDowngrade(Database db, int oldV, int newV) async {
    debugPrint('Fazendo upgrade da versao $oldV para $newV');
  }

  Future<int> insertUsuario(String nomeUsuario, String dataNascimento,
      String email, String senha) async {
    final db = await DBHelper.getInstance();
    try {
      final Map<String, dynamic> data = {
        'nomeUsuario': nomeUsuario,
        'dataNascimento': dataNascimento,
        'email': email,
        'senha': senha,
      };
      return await db.insert('usuario', data);
    } catch (e) {
      debugPrint('Error inserting user: $e');
      rethrow;
    }
  }

  Future<int> insertCalendario(DateTime dataHora, String tipo) async {
    final db = await DBHelper.getInstance();
    try {
      final Map<String, dynamic> data = {
        'dataHora': dataHora.toIso8601String(),
        'tipo': tipo,
      };
      return await db.insert('calendario', data);
    } catch (e) {
      debugPrint('Error inserting calendario: $e');
      rethrow;
    }
  }

  Future<int> insertMedicamento(
    String nomeMedicamento,
    String laboratorio,
    DateTime dataHora,
    String dosagem,
    String posologia,
    String horario,
    String tempoTratamento,
    String inicioTratamento,
    String fimTratamento,
    int quantidade,
    bool alarmeAtivo,
  ) async {
    final db = await DBHelper.getInstance();
    try {
      // Insira primeiro no calendário
      int idCalendario = await insertCalendario(dataHora, 'medicamento');

      final Map<String, dynamic> data = {
        'nomeMedicamento': nomeMedicamento,
        'laboratorio': laboratorio,
        'idCalendario': idCalendario.toString(), // Use o id gerado
        'dosagem': dosagem,
        'posologia': posologia,
        'horario': horario,
        'tempoTratamento': tempoTratamento,
        'incioTratamento': inicioTratamento,
        'fimTratamento': fimTratamento,
        'quantidade': quantidade,
        'alarmActive': alarmeAtivo ? 1 : 0, 
      };
      return await db.insert('medicamento', data);
    } catch (e) {
      debugPrint('Error inserting medicamento: $e');
      rethrow;
    }
  }

  /*Future<int> insertConsulta(
    String titulo,
    DateTime dataHora,
    String medico,
    String clinica,
    String endereco,
    String horario,
  ) async {
    final db = await DBHelper.getInstance();
    try {
      // Insira primeiro no calendário
      int idCalendario = await insertCalendario(dataHora, 'consulta');

      final Map<String, dynamic> data = {
        'titulo': titulo,
        'idCalendario': idCalendario.toString(), // Use o id gerado
        'medico': medico,
        'clinica': clinica,
        'endereco': endereco,
        'horario': horario,
      };
      return await db.insert('consulta', data);
    } catch (e) {
      debugPrint('Error inserting consulta: $e');
      rethrow;
    }
  }*/
  Future<int> insertConsulta(
  String titulo,
  DateTime dataHora,
  String medico,
  String clinica,
  String endereco,
  String horario,
  bool alarmeAtivo,
) async {
  final db = await DBHelper.getInstance();
  try {
    // Insira primeiro no calendário
    int idCalendario = await insertCalendario(dataHora, 'consulta');

    final Map<String, dynamic> data = {
      'titulo': titulo,
      'idCalendario': idCalendario.toString(), // Use o id gerado
      'medico': medico,
      'clinica': clinica,
      'endereco': endereco,
      'horario': horario,
      'alarmActive': alarmeAtivo ? 1 : 0,
    };
    return await db.insert('consulta', data);
  } catch (e) {
    debugPrint('Error inserting consulta: $e');
    rethrow;
  }
}

  Future<List<Medicamento>> getMedicamentos() async {
    final db = await DBHelper.getInstance();
    final List<Map<String, dynamic>> maps = await db.query('medicamento');

    return List.generate(maps.length, (i) {
      return Medicamento.fromMap(maps[i]);
    });
  }
  Future<void> updateQuantidade(int id, int novaQuantidade) async {
  final db = await getInstance();
  await db.update(
    'medicamento',
    {'quantidade': novaQuantidade},
    where: 'id = ?',
    whereArgs: [id],
  );
}

Future<void> deleteMedicamento(int id) async {
  final db = await getInstance();
  await db.delete(
    'medicamento',
    where: 'id = ?',
    whereArgs: [id],
  );
}
  Future<List<Medicamento>> getMedicamentosForDate(DateTime date) async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query(
      'medicamento',
      where: 'inicioTratamento <= ? AND fimTratamento >= ?',
      whereArgs: [date.toIso8601String(), date.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return Medicamento.fromMap(maps[i]);
    });
  }

  Future<List<Consulta>> getConsultasForDate(DateTime date) async {
  final db = await getInstance();
  final List<Map<String, dynamic>> maps = await db.query(
    'consulta',
    where: 'horario >= ? AND horario < ?',
    whereArgs: [
      date.toIso8601String(), // Início do dia
      DateTime(date.year, date.month, date.day + 1).toIso8601String() // Início do próximo dia
    ],
  );

  return List.generate(maps.length, (i) {
    return Consulta.fromMap(maps[i]);
  });
}
Future<List<Consulta>> getConsultas() async {
  final db = await getInstance();
  final List<Map<String, dynamic>> maps = await db.query('consulta');

  return List.generate(maps.length, (i) {
    return Consulta.fromMap(maps[i]);
  });
}
  /*Future<List<Consulta>> getConsultasForDate(DateTime date) async {
    final db = await getInstance();
    final List<Map<String, dynamic>> maps = await db.query(
      'consulta',
      where: 'horario = ?',
      whereArgs: [date.toIso8601String()],
    );

    return List.generate(maps.length, (i) {
      return Consulta.fromMap(maps[i]);
    });
  }*/
  
}
