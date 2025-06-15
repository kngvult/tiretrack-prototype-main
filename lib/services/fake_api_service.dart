import 'dart:async';

import '../data/mock/mock_data.dart';
import '../data/mock/models.dart';

class FakeApiService {
  Future<List<Caminhao>> getCaminhoes() async {
    await Future.delayed(Duration(milliseconds: 500));
    return mockCaminhoes;
  }

  Future<Caminhao?> getCaminhaoById(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    try {
      return mockCaminhoes.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Pneu>> getPneus() async {
    await Future.delayed(Duration(milliseconds: 500));
    return mockPneus;
  }

  Future<List<Pneu>> getPneusByCaminhao(String idCaminhao) async {
    await Future.delayed(Duration(milliseconds: 500));
    return mockPneus.where((p) => p.idCaminhao == idCaminhao).toList();
  }

  Future<List<OrdemServico>> getOrdensServico(
      {String status = 'Pendente'}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return mockOrdens.where((o) => o.status == status).toList();
  }

  Future<List<OrdemServico>> getOrdensFinalizadas() async {
    return getOrdensServico(status: 'Finalizado');
  }

  Future<List<Alerta>> getAlertas() async {
    await Future.delayed(Duration(milliseconds: 500));
    return mockAlertas;
  }

  Future<void> addCaminhao(Caminhao caminhao) async {
    await Future.delayed(Duration(milliseconds: 300));
    mockCaminhoes.add(caminhao);
  }

  Future<void> addPneu(Pneu pneu) async {
    await Future.delayed(Duration(milliseconds: 300));
    mockPneus.add(pneu);
  }

  Future<void> criarOrdemServico(OrdemServico ordem) async {
    await Future.delayed(Duration(milliseconds: 300));
    mockOrdens.add(ordem);
  }

  Future<void> finalizarOrdem(String idRequisicao) async {
    await Future.delayed(Duration(milliseconds: 300));
    final ordem = mockOrdens.firstWhere((o) => o.idRequisicao == idRequisicao);
    ordem.status = 'Finalizado';
    ordem.dataManutencao = DateTime.now();
  }
}
