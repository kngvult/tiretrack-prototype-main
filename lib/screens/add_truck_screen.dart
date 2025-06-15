import 'package:flutter/material.dart';
import '../data/mock/mock_data.dart';
import '../data/mock/models.dart';

class AddTruckScreen extends StatefulWidget {
  const AddTruckScreen({Key? key}) : super(key: key);

  @override
  State<AddTruckScreen> createState() => _AddTruckScreenState();
}

class _AddTruckScreenState extends State<AddTruckScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _emplacamento;
  late String _modelo;
  late int _ano;
  late int _km;
  String _nextTruckId = '';

  @override
  void initState() {
    super.initState();
    _initializeTruckId();
  }

  void _initializeTruckId() {
    final id = _generateNextTruckId();
    setState(() {
      _nextTruckId = id;
    });
  }

  String _generateNextTruckId() {
    if (mockCaminhoes.isEmpty) {
      return 'CAM001';
    } else {
      final lastId = mockCaminhoes.last.id;
      final lastNum = int.tryParse(lastId.substring(3)) ?? 0;
      final nextNum = lastNum + 1;
      return 'CAM${nextNum.toString().padLeft(3, '0')}';
    }
  }

  void addTruck() {
    final newTruck = Caminhao(
      id: _nextTruckId,
      emplacamento: _emplacamento,
      modelo: _modelo,
      anoFabricacao: _ano,
      kmTotal: _km,
    );

    mockCaminhoes.add(newTruck);
    addPneus(_nextTruckId, _emplacamento);
    print('Caminhão adicionado (mock): $newTruck');
    Navigator.pop(context);
  }

  void addPneus(String truckId, String emplacamento) {
    for (int i = 1; i <= 10; i++) {
      final pneu = Pneu(
        id: '$emplacamento-P$i',
        idCaminhao: truckId,
        posicao: 'P$i',
        kmPneu: 0,
        dataUltimaManutencao: DateTime.now(),
      );
      mockPneus.add(pneu);
      print('Pneu adicionado (mock): $pneu');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Caminhão'),
        centerTitle: true,
      ),
      body: _nextTruckId.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          'ID do Caminhão: $_nextTruckId',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        buildTextField(
                          label: 'Emplacamento',
                          hint: 'Ex: ABC1D23',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o emplacamento';
                            } else if (!RegExp(r'^[A-Z0-9]{7}\$')
                                .hasMatch(value)) {
                              return 'Formato inválido (Ex: ABC1D23)';
                            }
                            return null;
                          },
                          onSaved: (value) => _emplacamento = value!,
                        ),
                        buildTextField(
                          label: 'Modelo',
                          hint: 'Ex: Scania R450',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o modelo';
                            }
                            return null;
                          },
                          onSaved: (value) => _modelo = value!,
                        ),
                        buildTextField(
                          label: 'Ano de Fabricação',
                          hint: 'Ex: 2020',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o ano';
                            }
                            final parsed = int.tryParse(value);
                            if (parsed == null ||
                                parsed < 1900 ||
                                parsed > DateTime.now().year) {
                              return 'Ano inválido';
                            }
                            return null;
                          },
                          onSaved: (value) => _ano = int.parse(value!),
                        ),
                        buildTextField(
                          label: 'KM Total',
                          hint: 'Ex: 120000',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o KM total';
                            }
                            final parsed = int.tryParse(value);
                            if (parsed == null || parsed < 0) {
                              return 'KM deve ser um número positivo';
                            }
                            return null;
                          },
                          onSaved: (value) => _km = int.parse(value!),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancelar'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    addTruck();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colorScheme.secondary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: const Text('Adicionar',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget buildTextField({
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    required FormFieldValidator<String> validator,
    required FormFieldSetter<String> onSaved,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: theme.colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
