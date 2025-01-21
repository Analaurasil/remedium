class Medicamento {
  final int? id;
  final String nomeMedicamento;
  final String laboratorio;
  final String idCalendario;
  final String dosagem;
  final String posologia;
  final String horario;
  final String tempoTratamento;
  final String inicioTratamento;
  final String fimTratamento;
  final int quantidade;

  Medicamento({
    this.id,
    required this.nomeMedicamento,
    required this.laboratorio,
    required this.idCalendario,
    required this.dosagem,
    required this.posologia,
    required this.horario,
    required this.tempoTratamento,
    required this.inicioTratamento,
    required this.fimTratamento,
    required this.quantidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeMedicamento': nomeMedicamento,
      'laboratorio': laboratorio,
      'idCalendario': idCalendario,
      'dosagem': dosagem,
      'posologia': posologia,
      'horario': horario,
      'tempoTratamento': tempoTratamento,
      'inicioTratamento': inicioTratamento,
      'fimTratamento': fimTratamento,
      'quantidade': quantidade,
    };
  }

 factory Medicamento.fromMap(Map<String, dynamic> map) {
  return Medicamento(
    id: map['id'],
    nomeMedicamento: map['nomeMedicamento'] ?? 'Nome não disponível', // Valor padrão
    laboratorio: map['laboratorio'] ?? 'Laboratório não disponível', // Valor padrão
    idCalendario: map['idCalendario'] ?? 'ID não disponível', // Valor padrão
    dosagem: map['dosagem'] ?? 'Dosagem não disponível', // Valor padrão
    posologia: map['posologia'] ?? 'Posologia não disponível', // Valor padrão
    horario: map['horario'] ?? 'Horário não disponível', // Valor padrão
    tempoTratamento: map['tempoTratamento'] ?? 'Tempo não disponível', // Valor padrão
    inicioTratamento: map['inicioTratamento'] ?? 'Início não disponível', // Valor padrão
    fimTratamento: map['fimTratamento'] ?? 'Fim não disponível', // Valor padrão
    quantidade: map['quantidade'] ?? 0, // Valor padrão
  );
}
}