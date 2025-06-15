import 'models.dart';

final List<Caminhao> mockCaminhoes = [
  Caminhao(
    id: 'CAM001',
    emplacamento: 'JTT9C91',
    modelo: 'Scania R 620',
    anoFabricacao: 2022,
    kmTotal: 120000,
  ),
  Caminhao(
      id: 'CAM002',
      emplacamento: 'FQS3V80',
      modelo: 'Mercedes-Benz Actros 2546',
      anoFabricacao: 2022,
      kmTotal: 120000),
  Caminhao(
      id: 'CAM003',
      emplacamento: 'XLZ8V44',
      modelo: 'Scania R 620',
      anoFabricacao: 2022,
      kmTotal: 120000),
  Caminhao(
      id: 'CAM004',
      emplacamento: 'HBG1Q01',
      modelo: 'Scania R 620',
      anoFabricacao: 2022,
      kmTotal: 120000),
  Caminhao(
      id: 'CAM005',
      emplacamento: 'EZR6O85',
      modelo: 'Volvo FH 540',
      anoFabricacao: 2022,
      kmTotal: 120000),
];

final List<Pneu> mockPneus = [
  Pneu(
    id: 'JTT9C91-P1',
    idCaminhao: 'CAM001',
    posicao: 'DE',
    kmPneu: 30000,
    dataUltimaManutencao: DateTime(2024, 8, 18),
    ultCalibragem: null,
    kmLimiteManutencao: null,
  ),
  Pneu(
      id: 'JTT9C91-P2',
      idCaminhao: 'CAM001',
      posicao: 'DD',
      kmPneu: 30000,
      dataUltimaManutencao: DateTime(2024, 8, 18),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'JTT9C91-P3',
      idCaminhao: 'CAM001',
      posicao: 'TE1',
      kmPneu: 30000,
      dataUltimaManutencao: DateTime(2024, 8, 18),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'JTT9C91-P4',
      idCaminhao: 'CAM001',
      posicao: 'TD1',
      kmPneu: 30000,
      dataUltimaManutencao: DateTime(2024, 8, 18),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'FQS3V80-P1',
      idCaminhao: 'CAM002',
      posicao: 'DE',
      kmPneu: 45000,
      dataUltimaManutencao: DateTime(2024, 8, 20),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'FQS3V80-P2',
      idCaminhao: 'CAM002',
      posicao: 'DD',
      kmPneu: 45000,
      dataUltimaManutencao: DateTime(2024, 8, 20),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'FQS3V80-P3',
      idCaminhao: 'CAM002',
      posicao: 'TE1',
      kmPneu: 45000,
      dataUltimaManutencao: DateTime(2024, 8, 20),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'FQS3V80-P4',
      idCaminhao: 'CAM002',
      posicao: 'TD1',
      kmPneu: 45000,
      dataUltimaManutencao: DateTime(2024, 8, 20),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'XLZ8V44-P1',
      idCaminhao: 'CAM003',
      posicao: 'DE',
      kmPneu: 60000,
      dataUltimaManutencao: DateTime(2024, 8, 22),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'XLZ8V44-P2',
      idCaminhao: 'CAM003',
      posicao: 'DD',
      kmPneu: 60000,
      dataUltimaManutencao: DateTime(2024, 8, 22),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'XLZ8V44-P3',
      idCaminhao: 'CAM003',
      posicao: 'TE1',
      kmPneu: 60000,
      dataUltimaManutencao: DateTime(2024, 8, 22),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'XLZ8V44-P4',
      idCaminhao: 'CAM003',
      posicao: 'TD1',
      kmPneu: 60000,
      dataUltimaManutencao: DateTime(2024, 8, 22),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'HBG1Q01-P1',
      idCaminhao: 'CAM004',
      posicao: 'DE',
      kmPneu: 75000,
      dataUltimaManutencao: DateTime(2024, 8, 24),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'HBG1Q01-P2',
      idCaminhao: 'CAM004',
      posicao: 'DD',
      kmPneu: 75000,
      dataUltimaManutencao: DateTime(2024, 8, 24),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'HBG1Q01-P3',
      idCaminhao: 'CAM004',
      posicao: 'TE1',
      kmPneu: 75000,
      dataUltimaManutencao: DateTime(2024, 8, 24),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'HBG1Q01-P4',
      idCaminhao: 'CAM004',
      posicao: 'TD1',
      kmPneu: 75000,
      dataUltimaManutencao: DateTime(2024, 8, 24),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'EZR6O85-P1',
      idCaminhao: 'CAM005',
      posicao: 'DE',
      kmPneu: 90000,
      dataUltimaManutencao: DateTime(2024, 8, 26),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'EZR6O85-P2',
      idCaminhao: 'CAM005',
      posicao: 'DD',
      kmPneu: 90000,
      dataUltimaManutencao: DateTime(2024, 8, 26),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'EZR6O85-P3',
      idCaminhao: 'CAM005',
      posicao: 'TE1',
      kmPneu: 90000,
      dataUltimaManutencao: DateTime(2024, 8, 26),
      ultCalibragem: null,
      kmLimiteManutencao: null),
  Pneu(
      id: 'EZR6O85-P4',
      idCaminhao: 'CAM005',
      posicao: 'TD1',
      kmPneu: 90000,
      dataUltimaManutencao: DateTime(2024, 8, 26),
      ultCalibragem: null,
      kmLimiteManutencao: null),

  // Adicione os demais conforme necessário
];

final List<OrdemServico> mockOrdensFinalizadas = [
  OrdemServico(
    idRequisicao: 'REQ1726940384367',
    idCaminhao: 'CAM005',
    pneuId: 'EZR6O85-P4',
    descricao: 'realizada a recapagem do pneu',
    urgencia: 'Média',
    status: 'Finalizado',
    dataSolicitacao: DateTime(2024, 9, 21, 13, 39, 44),
    dataManutencao: DateTime(2024, 9, 21, 13, 40, 12),
  ),
];

final List<OrdemServico> mockOrdens = [
  OrdemServico(
    idRequisicao: 'REQ202506081234',
    idCaminhao: 'CAM001',
    pneuId: 'JTT9C91-P2',
    descricao: 'Solicitado reparo por desgaste irregular',
    urgencia: 'Alta',
    status: 'Pendente',
    dataSolicitacao: DateTime(2025, 6, 7, 14, 35),
    dataManutencao: null,
  ),
  OrdemServico(
    idRequisicao: 'REQ1726940384367',
    idCaminhao: 'CAM005',
    pneuId: 'EZR6O85-P4',
    descricao: 'Realizada a recapagem do pneu.',
    status: 'Finalizado',
    dataSolicitacao: DateTime(2024, 9, 21, 13, 39, 44),
    dataManutencao: DateTime(2024, 9, 21, 13, 40, 12),
    urgencia: 'Alta',
    obsAdicionais: 'Pneu estava severamente desgastado.',
  ),
  OrdemServico(
    idRequisicao: 'REQ202506071150',
    idCaminhao: 'CAM001',
    pneuId: 'JTT9C91-P2',
    descricao: 'Correção de pressão dos pneus traseiros.',
    status: 'Finalizado',
    dataSolicitacao: DateTime(2025, 6, 7, 11, 50),
    dataManutencao: DateTime(2025, 6, 7, 12, 10),
    urgencia: 'Média',
    obsAdicionais: 'Calibragem fora dos padrões recomendados.',
  ),
  OrdemServico(
    idRequisicao: 'REQ202506061015',
    idCaminhao: 'CAM001',
    pneuId: 'JTT9C91-P4',
    descricao: 'Substituição de pneu desgastado.',
    status: 'Finalizado',
    dataSolicitacao: DateTime(2025, 6, 6, 10, 15),
    dataManutencao: DateTime(2025, 6, 6, 10, 45),
    urgencia: 'Alta',
    obsAdicionais: 'Pneu apresentava risco de estouro.',
  ),
];

final List<Alerta> mockAlertas = [
  Alerta(
    mensagem: "Pneu dianteiro desgastado",
    nivel: "Alto",
    idCaminhao: "CAM003",
    modelo: "Scania R 620",
    idPneu: "XLZ8V44-P1",
    posicao: "DE",
  ),
  Alerta(
    mensagem: "Calibragem insuficiente detectada",
    nivel: "Médio",
    idCaminhao: "CAM005",
    modelo: "Volvo FH 540",
    idPneu: "EZR6O85-P3",
    posicao: "TE1",
  ),
  Alerta(
    mensagem: "Desgaste irregular no eixo traseiro",
    nivel: "Alto",
    idCaminhao: "CAM001",
    modelo: "Scania R 620",
    idPneu: "JTT9C91-P4",
    posicao: "TD1",
  ),
  Alerta(
    mensagem: "Pneu lateral com perda de pressão frequente",
    nivel: "Baixo",
    idCaminhao: "CAM002",
    modelo: "Mercedes-Benz Actros",
    idPneu: "FQS3V80-P2",
    posicao: "DD",
  ),
];

final Map<String, List<int>> maintenanceRequests = {
  'monthly': [5, 10, 7, 3, 8, 15],
  'semiannual': [30, 25],
  'annual': [75]
};

final Map<String, List<int>> recapRequests = {
  'monthly': [3, 6, 4, 8, 5, 7],
  'semiannual': [20, 18],
  'annual': [45]
};

final Map<String, List<int>> tireReplacements = {
  'monthly': [2, 5, 3, 6, 2, 8],
  'semiannual': [15, 14],
  'annual': [35]
};

final Map<String, List<int>> tireSales = {
  'monthly': [1, 2, 3, 4, 5, 6],
  'semiannual': [12, 10],
  'annual': [28]
};
