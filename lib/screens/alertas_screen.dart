import 'package:flutter/material.dart';
import '../data/mock/mock_data.dart';
import '../data/mock/models.dart';

class AlertasScreen extends StatefulWidget {
  @override
  _AlertasScreenState createState() => _AlertasScreenState();
}

class _AlertasScreenState extends State<AlertasScreen> {
  List<Alerta> alertas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAlertas();
  }

  void fetchAlertas() {
    setState(() {
      alertas = mockAlertas;
      isLoading = false;
    });
  }

  void _showAlertDetail(Alerta alerta) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.redAccent, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Detalhes do Alerta',
                  style: theme.textTheme.titleLarge,
                ),
                const Divider(height: 30, thickness: 1.5),
                _buildDetailRow(
                    Icons.directions_car, "Caminhão ID", alerta.idCaminhao),
                _buildDetailRow(Icons.trip_origin, "Pneu ID", alerta.idPneu),
                _buildDetailRow(Icons.place, "Posição", alerta.posicao),
                _buildDetailRow(Icons.priority_high, "Nível", alerta.nivel),
                _buildDetailRow(Icons.message, "Mensagem", alerta.mensagem),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: theme.iconTheme.color),
                    label: Text("Fechar", style: theme.textTheme.bodyMedium),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.secondary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(text: value),
                ],
              ),
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
        title: const Text('Alertas de Manutenção'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : alertas.isEmpty
              ? const Center(
                  child: Text(
                    'Sem alertas disponíveis.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: alertas.length,
                    itemBuilder: (context, index) {
                      final alerta = alertas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          onTap: () => _showAlertDetail(alerta),
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
                                        'Pneu ID: ${alerta.idPneu}',
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      Text('Caminhão ID: ${alerta.idCaminhao}',
                                          style: theme.textTheme.bodyMedium),
                                      const SizedBox(height: 4),
                                      Text('Posição: ${alerta.posicao}',
                                          style: theme.textTheme.bodyMedium),
                                      const SizedBox(height: 4),
                                      Text('Nível: ${alerta.nivel}',
                                          style: theme.textTheme.bodyMedium),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.warning, color: Colors.red),
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
