import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/mock/mock_data.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String selectedPeriod = 'monthly';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDropdown(theme),
            const SizedBox(height: 20),
            _buildChart(
                "Requisições de Manutenção", maintenanceRequests, theme),
            _buildChart("Pneus Recapados", recapRequests, theme),
            _buildChart("Pneus Trocados", tireReplacements, theme),
            _buildChart("Pneus Vendidos", tireSales, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Período",
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: selectedPeriod,
          isExpanded: true,
          style: theme.textTheme.bodyMedium,
          items: const [
            DropdownMenuItem(child: Text("Mensal"), value: 'monthly'),
            DropdownMenuItem(child: Text("Semestral"), value: 'semiannual'),
            DropdownMenuItem(child: Text("Anual"), value: 'annual'),
          ],
          onChanged: (value) {
            setState(() {
              selectedPeriod = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildChart(
      String title, Map<String, List<int>> dataSource, ThemeData theme) {
    final data = dataSource[selectedPeriod]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          height: 220,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: data
                      .asMap()
                      .entries
                      .map((entry) =>
                          FlSpot(entry.key.toDouble(), entry.value.toDouble()))
                      .toList(),
                  isCurved: true,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.secondary,
                      theme.colorScheme.primary.withOpacity(0.7),
                    ],
                  ),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.secondary.withOpacity(0.3),
                        theme.colorScheme.secondary.withOpacity(0.05),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) =>
                        FlDotCirclePainter(
                      radius: 4,
                      color: theme.colorScheme.secondary,
                      strokeWidth: 0,
                    ),
                  ),
                  isStrokeCapRound: true,
                ),
              ],
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: 5,
                verticalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
                getDrawingVerticalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                    reservedSize: 32,
                    getTitlesWidget: (value, _) => Text(
                      '${value.toInt()}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 32,
                    getTitlesWidget: (value, _) {
                      List<String> labels;
                      if (selectedPeriod == 'monthly') {
                        labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                      } else if (selectedPeriod == 'semiannual') {
                        labels = ['H1', 'H2'];
                      } else {
                        labels = ['Ano'];
                      }
                      final index = value.toInt();
                      if (index < labels.length) {
                        return Text(
                          labels[index],
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey, fontSize: 10),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: (data.length - 1).toDouble(),
              minY: 0,
              maxY: (data.reduce((a, b) => a > b ? a : b) + 5).toDouble(),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
