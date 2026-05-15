import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/risk_calculator.dart';
import '../../data/isar/local_vital.dart';
import '../../providers/app_providers.dart';

class ChwVisitFormScreen extends ConsumerStatefulWidget {
  const ChwVisitFormScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  final String patientId;
  final String patientName;

  @override
  ConsumerState<ChwVisitFormScreen> createState() => _ChwVisitFormScreenState();
}

class _ChwVisitFormScreenState extends ConsumerState<ChwVisitFormScreen> {
  final _systolicCtrl = TextEditingController();
  final _diastolicCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _visitType = 'routine';
  bool _escalate = false;

  @override
  void dispose() {
    _systolicCtrl.dispose();
    _diastolicCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final systolic = int.tryParse(_systolicCtrl.text);
    final diastolic = int.tryParse(_diastolicCtrl.text);
    final input = RiskInput(systolicBp: systolic, diastolicBp: diastolic);
    final risk = RiskCalculator.calculate(input);

    final vital = LocalVital()
      ..localId = const Uuid().v4()
      ..patientId = widget.patientId
      ..systolicBp = systolic
      ..diastolicBp = diastolic
      ..notes = _notesCtrl.text
      ..syncStatus = SyncStatus.pending
      ..riskStatus = risk
      ..sourceType = 'chw_visit'
      ..captureLocationType = 'community'
      ..createdAt = DateTime.now();

    await ref.read(isarServiceProvider).saveVital(vital);
    ref.read(syncServiceProvider).scheduleBackgroundSync();

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Visit saved — risk: $risk')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visit: ${widget.patientName}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _visitType,
            decoration: const InputDecoration(labelText: 'Visit type'),
            items: const [
              DropdownMenuItem(value: 'routine', child: Text('Routine check')),
              DropdownMenuItem(value: 'follow_up', child: Text('Follow-up')),
              DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
            ],
            onChanged: (v) => setState(() => _visitType = v ?? 'routine'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _systolicCtrl,
            decoration: const InputDecoration(
              labelText: 'Top BP number',
              suffixText: 'mmHg',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _diastolicCtrl,
            decoration: const InputDecoration(
              labelText: 'Bottom BP number',
              suffixText: 'mmHg',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _notesCtrl,
            decoration: const InputDecoration(labelText: 'Visit notes'),
            maxLines: 3,
          ),
          SwitchListTile(
            title: const Text('Escalate to clinician'),
            value: _escalate,
            onChanged: (v) => setState(() => _escalate = v),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Complete visit'),
          ),
        ],
      ),
    );
  }
}
