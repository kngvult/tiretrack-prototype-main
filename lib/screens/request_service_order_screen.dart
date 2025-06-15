import 'package:flutter/material.dart';
import '../../services/fake_api_service.dart';
import '../../data/mock/models.dart';

class RequestServiceOrderScreen extends StatefulWidget {
  const RequestServiceOrderScreen({Key? key}) : super(key: key);

  @override
  _RequestServiceOrderScreenState createState() =>
      _RequestServiceOrderScreenState();
}

class _RequestServiceOrderScreenState extends State<RequestServiceOrderScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCaminhao;
  String? selectedPneu;
  final TextEditingController problemDescriptionController =
      TextEditingController();
  final TextEditingController additionalNotesController =
      TextEditingController();

  List<Caminhao> caminhoes = [];
  List<Pneu> pneus = [];

  final FakeApiService _fakeApi = FakeApiService();

  String? selectedUrgency;
  DateTime? preferredDate;

  @override
  void initState() {
    super.initState();
    fetchCaminhoes();
  }

  Future<void> fetchCaminhoes() async {
    final data = await _fakeApi.getCaminhoes();
    setState(() {
      caminhoes = data;
    });
  }

  Future<void> fetchPneus(String idCaminhao) async {
    final data = await _fakeApi.getPneusByCaminhao(idCaminhao);
    setState(() {
      pneus = data;
    });
  }

  Future<void> sendServiceOrder() async {
    if (selectedCaminhao != null &&
        selectedPneu != null &&
        problemDescriptionController.text.isNotEmpty) {
      final ordem = OrdemServico(
        idRequisicao: DateTime.now().millisecondsSinceEpoch.toString(),
        idCaminhao: selectedCaminhao!,
        pneuId: selectedPneu!,
        descricao: problemDescriptionController.text,
        status: 'Pendente',
        dataSolicitacao: DateTime.now(),
        dataManutencao: null,
        urgencia: selectedUrgency ?? '',
      );

      await _fakeApi.criarOrdemServico(ordem);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ordem de Serviço criada com sucesso!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Preencha todos os campos para abrir o chamado.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Solicitação de Serviço'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preencha os detalhes da solicitação',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 15),
                    _buildDropdownField<String>(
                      labelText: 'Selecione o Caminhão',
                      value: selectedCaminhao,
                      items:
                          caminhoes.map<DropdownMenuItem<String>>((caminhao) {
                        return DropdownMenuItem<String>(
                          value: caminhao.id,
                          child: Text('${caminhao.id} - ${caminhao.modelo}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCaminhao = value;
                          selectedPneu = null;
                          if (value != null) fetchPneus(value);
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildDropdownField<String>(
                      labelText: 'Selecione o Pneu',
                      value: selectedPneu,
                      items: pneus.map<DropdownMenuItem<String>>((pneu) {
                        return DropdownMenuItem<String>(
                          value: pneu.id,
                          child: Text('${pneu.id} - ${pneu.posicao}'),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedPneu = value),
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: 'Descrição do Problema',
                      controller: problemDescriptionController,
                      maxLines: 3,
                    ),
                    _buildDatePicker(context),
                    _buildUrgencyChips(),
                    _buildTextField(
                      label: 'Observações Adicionais',
                      controller: additionalNotesController,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: sendServiceOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: Text(
                            'Enviar Solicitação',
                            style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required String labelText,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      hint: Text(labelText),
      onChanged: onChanged,
      items: items,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
      isExpanded: true,
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (pickedDate != null) {
            setState(() => preferredDate = pickedDate);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor),
            borderRadius: BorderRadius.circular(15),
            color: theme.colorScheme.surface,
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: theme.colorScheme.secondary),
              const SizedBox(width: 8),
              Text(
                preferredDate != null
                    ? "${preferredDate?.day}/${preferredDate?.month}/${preferredDate?.year}"
                    : "Selecionar Data",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUrgencyChips() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Wrap(
        spacing: 10.0,
        children: [
          ChoiceChip(
            label: const Text('Baixa'),
            selected: selectedUrgency == 'Baixa',
            onSelected: (selected) =>
                setState(() => selectedUrgency = selected ? 'Baixa' : null),
            selectedColor: Colors.green[300],
            backgroundColor: theme.colorScheme.tertiary,
          ),
          ChoiceChip(
            label: const Text('Média'),
            selected: selectedUrgency == 'Média',
            onSelected: (selected) =>
                setState(() => selectedUrgency = selected ? 'Média' : null),
            selectedColor: Colors.orange[300],
            backgroundColor: theme.colorScheme.tertiary,
          ),
          ChoiceChip(
            label: const Text('Alta'),
            selected: selectedUrgency == 'Alta',
            onSelected: (selected) =>
                setState(() => selectedUrgency = selected ? 'Alta' : null),
            selectedColor: Colors.red[300],
            backgroundColor: theme.colorScheme.tertiary,
          ),
        ],
      ),
    );
  }
}
