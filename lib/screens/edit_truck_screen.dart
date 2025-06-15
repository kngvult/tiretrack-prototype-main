import 'package:flutter/material.dart';
import '../utils/mock_utils.dart';

class EditTruckScreen extends StatefulWidget {
  final List<Map<String, dynamic>> trucks;
  final Function({
    String? id,
    required String emplacamento,
    required String modelo,
    required int anoFabricacao,
    required int kmTotal,
  }) editTruck;

  const EditTruckScreen({
    Key? key,
    required this.trucks,
    required this.editTruck,
  }) : super(key: key);

  @override
  State<EditTruckScreen> createState() => _EditTruckScreenState();
}

class _EditTruckScreenState extends State<EditTruckScreen> {
  bool isLoading = false;
  Map<String, dynamic>? truckDetails;
  List<Map<String, dynamic>> tires = [];

  void fetchTruckDetails(String truckId) {
    setState(() => isLoading = true);
    final selectedTruck = widget.trucks.firstWhere((t) => t['id'] == truckId);
    setState(() {
      truckDetails = Map<String, dynamic>.from(selectedTruck);
      tires = getTruckTiresAsMap(truckId);
      isLoading = false;
    });
    showEditDialog();
  }

  void showEditDialog() {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 600),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Título
                  Text(
                    'Editar Caminhão',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Seção de dados do caminhão
                          Card(
                            color: theme.colorScheme.surfaceContainerHighest,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dados do Caminhão',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 12),
                                  buildTruckForm(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Seção de pneus
                          Card(
                            color: theme.colorScheme.surfaceContainerHighest,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pneus',
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 12),
                                  ...buildEditableTireFields(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botões de ação
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: saveTruckChanges,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Salvar'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void saveTruckChanges() {
    if (truckDetails == null) return;
    widget.editTruck(
      id: truckDetails!['id'],
      emplacamento: truckDetails!['emplacamento'],
      modelo: truckDetails!['modelo'],
      anoFabricacao: truckDetails!['anoFabricacao'],
      kmTotal: truckDetails!['kmTotal'],
    );
    Navigator.of(context).pop();
  }

  List<Widget> buildEditableTireFields() {
    final theme = Theme.of(context);
    return tires.asMap().entries.map((entry) {
      Map<String, dynamic> tire = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'ID: ${tire['id']} - Posição: ${tire['posicao']}',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Checkbox(
                value: tire['trocado'] ?? false,
                onChanged: (value) {
                  setState(() {
                    tire['trocado'] = value;
                    if (value == true) tire['kmPneu'] = 0;
                  });
                },
              ),
              const Text('Pneu Trocado'),
            ],
          ),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: tire['kmPneu'].toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'KM do Pneu',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) =>
                tire['kmPneu'] = int.tryParse(value) ?? tire['kmPneu'],
          ),
          const SizedBox(height: 16),
        ],
      );
    }).toList();
  }

  Widget buildTruckForm() {
    return Column(
      children: [
        TextFormField(
          initialValue: truckDetails!['emplacamento'],
          decoration: const InputDecoration(
            labelText: 'Emplacamento',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => truckDetails!['emplacamento'] = value,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: truckDetails!['modelo'],
          decoration: const InputDecoration(
            labelText: 'Modelo do Caminhão',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => truckDetails!['modelo'] = value,
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: truckDetails!['anoFabricacao']?.toString() ?? '',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Ano de Fabricação',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => truckDetails!['anoFabricacao'] =
              int.tryParse(value) ?? truckDetails!['anoFabricacao'],
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: truckDetails!['kmTotal']?.toString() ?? '',
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'KM Total',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => truckDetails!['kmTotal'] =
              int.tryParse(value) ?? truckDetails!['kmTotal'],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Caminhões'),
        centerTitle: true,
      ),
      body: widget.trucks.isEmpty
          ? const Center(child: Text('Nenhum caminhão disponível.'))
          : ListView.builder(
              itemCount: widget.trucks.length,
              itemBuilder: (context, index) {
                final truck = widget.trucks[index];
                return GestureDetector(
                  onTap: () => fetchTruckDetails(truck['id']),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(40, 0, 0, 0),
                          blurRadius: 6,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${truck['id']} - ${truck['modelo']}',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text('Emplacamento: ${truck['emplacamento']}',
                            style: theme.textTheme.bodyMedium),
                        Text('Ano de Fabricação: ${truck['anoFabricacao']}',
                            style: theme.textTheme.bodyMedium),
                        Text('KM Total: ${truck['kmTotal']}',
                            style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
