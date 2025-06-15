import '../data/mock/mock_data.dart'; // importa seus mocks
import '../data/mock/models.dart'; // importa os modelos Caminhao e Pneu

/// Converte uma lista de objetos Caminhao em uma lista de mapas
List<Map<String, dynamic>> getTrucksAsMap(List<Caminhao> lista) {
  return lista.map((c) {
    return {
      'idCaminhao': c.id,
      'emplacamento': c.emplacamento,
      'modelo': c.modelo,
      'anoFabricacao': c.anoFabricacao,
      'kmTotal': c.kmTotal,
    };
  }).toList();
}

/// Converte os pneus de um caminhão específico em uma lista de mapas
List<Map<String, dynamic>> getTruckTiresAsMap(String idCaminhao) {
  final pneusDoCaminhao =
      mockPneus.where((p) => p.idCaminhao == idCaminhao).toList();

  return pneusDoCaminhao.map((p) {
    return {
      'id': p.id,
      'idCaminhao': p.idCaminhao,
      'posicao': p.posicao,
      'kmPneu': p.kmPneu,
      'dataUltimaManutencao': p.dataUltimaManutencao.toIso8601String(),
      'ultCalibragem': p.ultCalibragem,
      'kmLimiteManutencao': p.kmLimiteManutencao,
    };
  }).toList();
}
