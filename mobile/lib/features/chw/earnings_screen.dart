import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChwEarningsScreen extends StatelessWidget {
  const ChwEarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earnings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Available balance'),
                  Text('₦24,500',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('Pending: ₦8,000 · Lifetime: ₦186,000'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('This week', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10000,
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (v, _) {
                        const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                        return Text(days[v.toInt() % 7]);
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: List.generate(7, (i) {
                  final amounts = [4000.0, 0.0, 8000.0, 4000.0, 0.0, 4000.0, 0.0];
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: amounts[i],
                        color: Theme.of(context).colorScheme.primary,
                        width: 16,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const ListTile(
            leading: Icon(Icons.check_circle, color: Colors.green),
            title: Text('Home visit — Adaeze'),
            subtitle: Text('28 Apr · Released'),
            trailing: Text('₦6,400'),
          ),
          const ListTile(
            leading: Icon(Icons.hourglass_top, color: Colors.orange),
            title: Text('BP follow-up — Emeka'),
            subtitle: Text('Pending confirmation'),
            trailing: Text('₦2,000'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payout request sent to admin')),
              );
            },
            child: const Text('Request payout'),
          ),
        ],
      ),
    );
  }
}
