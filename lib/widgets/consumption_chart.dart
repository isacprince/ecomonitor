import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ConsumptionChart extends StatelessWidget {
  // Dados de exemplo, substitua pelos dados reais do banco de dados
  final List<double> weeklyConsumption = [2.5, 3.0, 2.8, 3.5, 4.0, 3.2, 2.9];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: bottomTitleWidgets,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: weeklyConsumption
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.green,
              barWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12);
    List<String> days = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];
    String text = days[value.toInt() % days.length];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }
}
