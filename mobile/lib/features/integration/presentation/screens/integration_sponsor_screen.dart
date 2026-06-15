import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/pilot_data.dart';
import '../widgets/integration_shell.dart';

class IntegrationSponsorScreen extends ConsumerStatefulWidget {
  const IntegrationSponsorScreen({super.key});

  @override
  ConsumerState<IntegrationSponsorScreen> createState() =>
      _IntegrationSponsorScreenState();
}

class _IntegrationSponsorScreenState
    extends ConsumerState<IntegrationSponsorScreen> {
  String _selectedPlan = 'family_care';
  String? _selectedChw = 'chw-amina';

  static const _mockVitals = [
    (date: 'Jun 1', sys: 128, dia: 82),
    (date: 'Jun 2', sys: 132, dia: 84),
    (date: 'Jun 3', sys: 126, dia: 80),
    (date: 'Jun 4', sys: 138, dia: 88),
    (date: 'Jun 5', sys: 130, dia: 83),
    (date: 'Jun 6', sys: 124, dia: 79),
    (date: 'Jun 7', sys: 136, dia: 86),
  ];

  static const _mockAlerts = [
    ('BP elevated — follow up', 'yellow'),
    ('Missed remote check', 'yellow'),
    ('Visit verified — Grace Okafor', 'green'),
  ];

  static const _mockVisits = [
    ('Jun 5', 'Amina Bello', 'Routine', 'Verified'),
    ('May 29', 'Amina Bello', 'Follow-up', 'Verified'),
    ('May 22', 'Fatima Abdullahi', 'Routine', 'Pending OTP'),
  ];

  @override
  Widget build(BuildContext context) {
    return IntegrationShell(
      title: 'Family sponsor',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Grace Okafor — Ilorin home monitoring pilot',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          Text('Pricing packages', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...pricingTiers.map((tier) {
            final selected = _selectedPlan == tier.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                color: selected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: InkWell(
                  onTap: () => setState(() => _selectedPlan = tier.id),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tier.name,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(tier.description,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text(
                          '₦${tier.priceMin.toString()}–₦${tier.priceMax.toString()}/mo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Text('Assign a CHW — Ilorin',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...ilorinChwProfiles.map((chw) {
            final selected = _selectedChw == chw.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                color: selected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: InkWell(
                  onTap: () => setState(() => _selectedChw = chw.id),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chw.name,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(chw.area,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: chw.badges
                              .map(
                                (b) => Chip(
                                  label: Text(b, style: const TextStyle(fontSize: 11)),
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: Colors.green.shade100,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          Text('BP trend (14 days)',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      getTitlesWidget: (v, _) {
                        final i = v.toInt();
                        if (i < 0 || i >= _mockVitals.length) {
                          return const SizedBox.shrink();
                        }
                        return Text(_mockVitals[i].date,
                            style: const TextStyle(fontSize: 10));
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (v, _) =>
                          Text('${v.toInt()}', style: const TextStyle(fontSize: 10)),
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < _mockVitals.length; i++)
                        FlSpot(i.toDouble(), _mockVitals[i].sys.toDouble()),
                    ],
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: [
                      for (var i = 0; i < _mockVitals.length; i++)
                        FlSpot(i.toDouble(), _mockVitals[i].dia.toDouble()),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Alerts', style: Theme.of(context).textTheme.titleMedium),
          ..._mockAlerts.map(
            (a) => ListTile(
              leading: Icon(
                Icons.circle,
                size: 12,
                color: a.$2 == 'green'
                    ? Colors.green
                    : a.$2 == 'yellow'
                        ? Colors.amber
                        : Colors.red,
              ),
              title: Text(a.$1),
              subtitle: Text(
                a.$2 == 'green'
                    ? 'Normal'
                    : a.$2 == 'yellow'
                        ? 'Caution'
                        : 'Urgent',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Visit history', style: Theme.of(context).textTheme.titleMedium),
          ..._mockVisits.map(
            (v) => ListTile(
              title: Text('${v.$1} — ${v.$2}'),
              subtitle: Text('${v.$3} · ${v.$4}'),
            ),
          ),
        ],
      ),
    );
  }
}
