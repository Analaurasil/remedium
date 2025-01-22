class Consulta {
  final int? id;
  final String titulo;
  final String idCalendario;
  final String medico;
  final String clinica;
  final String endereco;
  final String horario;
  bool alarmActive; 

  Consulta({
    this.id,
    required this.titulo,
    required this.idCalendario,
    required this.medico,
    required this.clinica,
    required this.endereco,
    required this.horario,
    this.alarmActive = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'idCalendario': idCalendario,
      'medico': medico,
      'clinica': clinica,
      'endereco': endereco,
      'horario': horario,
      'alarmActive': alarmActive ? 1 : 0,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      id: map['id'],
      titulo: map['titulo'] ?? 'Título não disponível',
      idCalendario: map['idCalendario'] ?? 'ID não disponível',
      medico: map['medico'] ?? 'Médico não disponível',
      clinica: map['clinica'] ?? 'Clínica não disponível',
      endereco: map['endereco'] ?? 'Endereço não disponível',
      horario: map['horario'] ?? 'Horário não disponível',
       alarmActive: map['alarmActive'] == 1,
    );
  }
}