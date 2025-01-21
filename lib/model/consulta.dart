class Consulta {
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
    required this.horario,
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
    );
  }
}