class Caminhao {
  final String id;
  final String emplacamento;
  final String modelo;
  final int anoFabricacao;
  final int kmTotal;

  Caminhao({
    required this.id,
    required this.emplacamento,
    required this.modelo,
    required this.anoFabricacao,
    required this.kmTotal,
  });
}

class Pneu {
  final String id;
  final String idCaminhao;
  final String posicao;
  final int kmPneu;
  final DateTime dataUltimaManutencao;
  final double? ultCalibragem;
  final int? kmLimiteManutencao;

  Pneu({
    required this.id,
    required this.idCaminhao,
    required this.posicao,
    required this.kmPneu,
    required this.dataUltimaManutencao,
    this.ultCalibragem,
    this.kmLimiteManutencao,
  });
}

class OrdemServico {
  final String idRequisicao;
  final String idCaminhao;
  final String pneuId;
  final String descricao;
  final String urgencia;
  final String? obsAdicionais;
  String status;
  final DateTime dataSolicitacao;
  DateTime? dataManutencao;

  OrdemServico({
    required this.idRequisicao,
    required this.idCaminhao,
    required this.pneuId,
    required this.descricao,
    required this.urgencia,
    this.obsAdicionais,
    required this.status,
    required this.dataSolicitacao,
    this.dataManutencao,
  });
}

class Alerta {
  final String mensagem;
  final String nivel;
  final String idCaminhao;
  final String idPneu;
  final String posicao;
  final String modelo;

  Alerta({
    required this.mensagem,
    required this.nivel,
    required this.idCaminhao,
    required this.idPneu,
    required this.posicao,
    required this.modelo,
  });
}
