import 'package:flutter/material.dart';
import '../data/mock/mock_data.dart';

class MaintenanceHistoryScreen extends StatefulWidget {
  @override
  _MaintenanceHistoryScreenState createState() =>
      _MaintenanceHistoryScreenState();
}

class _MaintenanceHistoryScreenState extends State<MaintenanceHistoryScreen> {
  List<Map<String, dynamic>> finalizedOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFinalizedOrders();
  }

  Future<void> fetchFinalizedOrders() async {
    await Future.delayed(Duration(milliseconds: 500));
    List<Map<String, dynamic>> finalizadas = mockOrdens
        .where((ordem) => ordem.status == 'Finalizado')
        .map((ordem) => {
              'id_requisicao': ordem.idRequisicao,
              'id_caminhao': ordem.idCaminhao,
              'pneu_id': ordem.pneuId,
              'descricao': ordem.descricao,
              'obs_adicionais': ordem.obsAdicionais ?? 'Nenhuma',
              'data_manutencao':
                  ordem.dataManutencao?.toString() ?? 'Indefinida',
              'urgencia': ordem.urgencia,
            })
        .toList();

    setState(() {
      finalizedOrders = finalizadas;
      isLoading = false;
    });
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Detalhes da Ordem #${order['id_requisicao']}',
            style: theme.textTheme.titleLarge
                ?.copyWith(color: theme.colorScheme.secondary),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildDetailRow('Caminhão', order['id_caminhao']),
                _buildDetailRow('Pneu', order['pneu_id']),
                _buildDetailRow('Descrição', order['descricao']),
                _buildDetailRow('Observações', order['obs_adicionais']),
                _buildDetailRow(
                    'Data de Finalização', order['data_manutencao']),
                _buildDetailRow('Urgência', order['urgencia']),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Fechar',
                  style: TextStyle(color: theme.colorScheme.primary)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Manutenções'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : finalizedOrders.isEmpty
              ? const Center(
                  child: Text(
                    'Sem históricos de manutenções finalizadas.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: finalizedOrders.length,
                    itemBuilder: (context, index) {
                      final order = finalizedOrders[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () => _showOrderDetails(order),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ordem de Serviço: ${order['id_requisicao']}',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text('Caminhão: ${order['id_caminhao']}',
                                          style: theme.textTheme.bodyMedium),
                                      const SizedBox(height: 4),
                                      Text('Pneu: ${order['pneu_id']}',
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: const [
                                    Icon(Icons.check_circle,
                                        color: Colors.green),
                                    SizedBox(height: 4),
                                    Text(
                                      'Finalizado',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
