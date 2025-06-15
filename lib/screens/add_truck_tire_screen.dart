import 'package:TireTrack/data/mock/mock_data.dart';
import 'package:TireTrack/data/mock/models.dart';
import 'package:flutter/material.dart';

import 'edit_truck_screen.dart';
import 'add_truck_screen.dart';

class AddTruckTireScreen extends StatefulWidget {
  const AddTruckTireScreen({Key? key}) : super(key: key);

  @override
  State<AddTruckTireScreen> createState() => _AddTruckTireScreenState();
}

class _AddTruckTireScreenState extends State<AddTruckTireScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> trucks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchTrucks() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    final mockList = mockCaminhoes
        .map((c) => {
              'id': c.id,
              'emplacamento': c.emplacamento,
              'modelo': c.modelo,
              'anoFabricacao': c.anoFabricacao,
              'kmTotal': c.kmTotal,
            })
        .toList();

    setState(() {
      trucks = mockList;
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTruckScreen(
          trucks: trucks,
          editTruck: editTruck,
        ),
      ),
    );
  }

  void editTruck({
    String? id,
    required String emplacamento,
    required String modelo,
    required int anoFabricacao,
    required int kmTotal,
  }) {
    final index = mockCaminhoes.indexWhere((c) => c.id == id);
    if (index != -1) {
      mockCaminhoes[index] = Caminhao(
        id: id!,
        emplacamento: emplacamento,
        modelo: modelo,
        anoFabricacao: anoFabricacao,
        kmTotal: kmTotal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Frota'),
        centerTitle: true,
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.primaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.appBarTheme.backgroundColor ?? theme.primaryColor,
                theme.appBarTheme.backgroundColor ?? theme.primaryColor
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    buildOptionCard(
                      icon: Icons.visibility,
                      title: 'Exibir Frota',
                      subtitle: 'Visualize todos os caminhões da sua frota',
                      onTap: fetchTrucks,
                      theme: theme,
                    ),
                    const SizedBox(height: 20),
                    buildOptionCard(
                      icon: Icons.add_circle,
                      title: 'Adicionar à Frota',
                      subtitle: 'Cadastre novos caminhões na sua frota',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTruckScreen(),
                          ),
                        );
                      },
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    final colorScheme = theme.colorScheme;
    final iconColor = theme.iconTheme.color ?? colorScheme.secondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(40, 0, 0, 0),
              blurRadius: 10,
              offset: Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 40, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      color: theme.textTheme.bodySmall?.color ?? Colors.grey,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
