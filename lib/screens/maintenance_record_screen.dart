import 'package:flutter/material.dart';
import '../../services/fake_api_service.dart';
import '../../data/mock/models.dart';
import '../../data/mock/mock_data.dart';

class MaintenanceRecordScreen extends StatefulWidget {
  @override
  _MaintenanceRecordScreenState createState() =>
      _MaintenanceRecordScreenState();
}

class _MaintenanceRecordScreenState extends State<MaintenanceRecordScreen> {
  List<OrdemServico> serviceOrders = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchServiceOrders();
  }

  Future<void> fetchServiceOrders() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      serviceOrders = mockOrdens;
      isLoading = false;
    });
  }

  void concludeService(String idRequisicao) {
    setState(() {
      final index = serviceOrders
          .indexWhere((order) => order.idRequisicao == idRequisicao);
      if (index != -1) {
        serviceOrders[index] = OrdemServico(
          idRequisicao: serviceOrders[index].idRequisicao,
          idCaminhao: serviceOrders[index].idCaminhao,
          pneuId: serviceOrders[index].pneuId,
          descricao: serviceOrders[index].descricao,
          status: 'Finalizado',
          dataSolicitacao: serviceOrders[index].dataSolicitacao,
          dataManutencao: DateTime.now(),
          urgencia: serviceOrders[index].urgencia,
          obsAdicionais: serviceOrders[index].obsAdicionais,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Serviço marcado como finalizado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordens de Serviço'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: serviceOrders.length,
              itemBuilder: (context, index) {
                final order = serviceOrders[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 4,
                  child: ListTile(
                    title: Text('Ordem de Serviço: ${order.idRequisicao}',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text('Pneu: ${order.pneuId}'),
                        Text('Status: ${order.status}'),
                        Text('Descrição: ${order.descricao}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MaintenanceDetailScreen(order: order),
                        ),
                      );
                    },
                    /*trailing: order.status != 'Finalizado'
                        ? ElevatedButton(
                            onPressed: () =>
                                concludeService(order.idRequisicao),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Finalizar'),
                          )
                        : const Icon(Icons.check_circle, color: Colors.green),
                  */
                  ),
                );
              },
            ),
    );
  }
}

class MaintenanceDetailScreen extends StatefulWidget {
  final OrdemServico order;
  const MaintenanceDetailScreen({Key? key, required this.order})
      : super(key: key);

  @override
  _MaintenanceDetailScreenState createState() =>
      _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends State<MaintenanceDetailScreen> {
  final FakeApiService _fakeApi = FakeApiService();

  String? selectedAction;
  String? selectedMaintenance;
  String? selectedSubstitution;

  // Listas de opções para dropdowns
  final List<String> actions = ['Manutenção', 'Substituição'];
  final List<String> maintenanceOptions = [
    'Recapagem',
    'Concerto do Pneu',
    'Alinhamento'
  ];
  final List<String> substitutionOptions = [
    'Rodízio',
    'Estoque',
    'Sucateado',
    'Vendido'
  ];

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context); // Ainda não utilizado, pode remover se desejar.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Manutenção'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailCard(),
                const SizedBox(height: 20),
                buildActionServiceCard(),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await concludeService(widget.order);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: Text(
                        'Concluir Serviço',
                        style: TextStyle(color: theme.colorScheme.onPrimary),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetailCard() {
    final order = widget.order;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalhes da Ordem de Serviço',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            _buildDetailRow('Ordem de Serviço:', order.idRequisicao),
            _buildDetailRow('Identificação do Veículo:', order.idCaminhao),
            _buildDetailRow('Pneu para Manutenção:', order.pneuId),
            _buildDetailRow('Urgência:', order.urgencia, isUrgent: true),
            _buildDetailRow(
                'Data da Requisição:', order.dataSolicitacao.toString()),
            const SizedBox(height: 20),
            const Text('Descrição do Problema:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(order.descricao, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Observações Adicionais:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(order.obsAdicionais ?? 'Nenhuma',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, {bool isUrgent = false}) {
    Color? boxColor;
    Color textColor;

    switch (value) {
      case 'Baixa':
        boxColor = Colors.green[100];
        textColor = Colors.green;
        break;
      case 'Média':
        boxColor = Colors.orange[100];
        textColor = Colors.orange;
        break;
      case 'Alta':
        boxColor = Colors.red[100];
        textColor = Colors.red;
        break;
      default:
        boxColor = Colors.transparent;
        textColor = Colors.black;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          if (isUrgent)
            Container(
              decoration: BoxDecoration(
                color: boxColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Text(value, style: TextStyle(color: textColor)),
            )
          else
            Text(value),
        ],
      ),
    );
  }

  Widget buildActionServiceCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Serviço Realizado',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
            const SizedBox(height: 20),
            // Dropdown para ação
            DropdownButton<String>(
              value: selectedAction,
              hint: const Text('Selecione uma ação'),
              isExpanded: true,
              items: actions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAction = newValue;
                  selectedMaintenance = null;
                  selectedSubstitution = null;
                });
              },
            ),
            const SizedBox(height: 16),
            if (selectedAction == 'Manutenção') ...[
              const Text('Escolha a Manutenção',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedMaintenance,
                hint: const Text('Selecione uma manutenção'),
                isExpanded: true,
                items: maintenanceOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMaintenance = newValue;
                  });
                },
              ),
            ],
            if (selectedAction == 'Substituição') ...[
              const Text('Tipo de Substituição',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: selectedSubstitution,
                hint: const Text('Selecione uma substituição'),
                isExpanded: true,
                items: substitutionOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSubstitution = newValue;
                  });
                },
              ),
            ],
            const SizedBox(height: 16),
            _buildInputField('Calibragem do Pneu (PSI)'),
            const SizedBox(height: 16),
            _buildInputField('Profundidade dos Sulcos (mm)'),
            const SizedBox(height: 16),
            _buildInputField('Observações', maxLines: 5),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Future<void> concludeService(OrdemServico ordem) async {
    try {
      await _fakeApi.finalizarOrdem(ordem.idRequisicao);
      Navigator.pop(context);
    } catch (e) {
      print('Erro ao finalizar serviço: $e');
    }
  }
}
