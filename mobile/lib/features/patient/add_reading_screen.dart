import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants.dart';
import '../../core/risk_calculator.dart';
import '../../data/isar/local_vital.dart';
import '../../providers/app_providers.dart';

class AddReadingScreen extends ConsumerStatefulWidget {
  const AddReadingScreen({super.key});

  @override
  ConsumerState<AddReadingScreen> createState() => _AddReadingScreenState();
}

class _AddReadingScreenState extends ConsumerState<AddReadingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _systolicCtrl = TextEditingController();
  final _diastolicCtrl = TextEditingController();
  final _pulseCtrl = TextEditingController();
  final _fastingGlucoseCtrl = TextEditingController();
  final _randomGlucoseCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  bool _medicationTaken = false;
  final _symptoms = <String>{};
  static const _symptomOptions = [
    'headache',
    'dizziness',
    'chest pain',
    'blurred vision',
    'fatigue',
  ];

  @override
  void dispose() {
    _systolicCtrl.dispose();
    _diastolicCtrl.dispose();
    _pulseCtrl.dispose();
    _fastingGlucoseCtrl.dispose();
    _randomGlucoseCtrl.dispose();
    _weightCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  int? _parseInt(String? v) => v != null && v.isNotEmpty ? int.tryParse(v) : null;
  double? _parseDouble(String? v) =>
      v != null && v.isNotEmpty ? double.tryParse(v) : null;

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = ref.read(sharedPreferencesProvider);
    final patientId = prefs.getString(AppConstants.prefsPatientId) ?? 'local';

    final systolic = _parseInt(_systolicCtrl.text);
    final diastolic = _parseInt(_diastolicCtrl.text);
    final fasting = _parseDouble(_fastingGlucoseCtrl.text);
    final random = _parseDouble(_randomGlucoseCtrl.text);

    final input = RiskInput(
      systolicBp: systolic,
      diastolicBp: diastolic,
      glucoseFasting: fasting,
      glucoseRandom: random,
      symptoms: _symptoms.toList(),
    );
    final risk = RiskCalculator.calculate(input);

    final vital = LocalVital()
      ..localId = const Uuid().v4()
      ..patientId = patientId
      ..systolicBp = systolic
      ..diastolicBp = diastolic
      ..pulse = _parseInt(_pulseCtrl.text)
      ..glucoseFasting = fasting
      ..glucoseRandom = random
      ..weightKg = _parseDouble(_weightCtrl.text)
      ..symptoms = _symptoms.toList()
      ..medicationTaken = _medicationTaken
      ..notes = _notesCtrl.text
      ..syncStatus = SyncStatus.pending
      ..riskStatus = risk
      ..createdAt = DateTime.now();

    await ref.read(isarServiceProvider).saveVital(vital);
    ref.invalidate(patientVitalsProvider(patientId));
    ref.read(syncServiceProvider).scheduleBackgroundSync();

    if (!mounted) return;
    final color = risk == 'red'
        ? Colors.red
        : risk == 'yellow'
            ? Colors.orange
            : Colors.green;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved offline — risk: $risk'),
        backgroundColor: color,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add reading')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Blood pressure',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _systolicCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Top BP number',
                      hintText: 'e.g. 120',
                      suffixText: 'mmHg',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _diastolicCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Bottom BP number',
                      hintText: 'e.g. 80',
                      suffixText: 'mmHg',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pulseCtrl,
              decoration: const InputDecoration(
                labelText: 'Pulse',
                suffixText: 'bpm',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Text('Glucose', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextFormField(
              controller: _fastingGlucoseCtrl,
              decoration: const InputDecoration(
                labelText: 'Fasting glucose',
                suffixText: 'mg/dL',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _randomGlucoseCtrl,
              decoration: const InputDecoration(
                labelText: 'Random glucose',
                suffixText: 'mg/dL',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _weightCtrl,
              decoration: const InputDecoration(
                labelText: 'Weight',
                suffixText: 'kg',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            Text('Symptoms', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _symptomOptions.map((s) {
                final selected = _symptoms.contains(s);
                return FilterChip(
                  label: Text(s),
                  selected: selected,
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        _symptoms.add(s);
                      } else {
                        _symptoms.remove(s);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('I took my medication today'),
              value: _medicationTaken,
              onChanged: (v) => setState(() => _medicationTaken = v),
            ),
            TextFormField(
              controller: _notesCtrl,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save reading'),
            ),
            const SizedBox(height: 8),
            Text(
              'Saved on your phone first, then synced when online.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
