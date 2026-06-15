import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/risk_calculator.dart';
import '../../../../data/isar/local_vital.dart';
import '../../../../providers/app_providers.dart';
import '../../../../widgets/yoruba_prompt_button.dart';
import '../../providers/integration_auth_provider.dart';
import '../widgets/integration_shell.dart';
import '../widgets/visit_verification_sheet.dart';

class IntegrationCheckupScreen extends ConsumerStatefulWidget {
  const IntegrationCheckupScreen({super.key});

  @override
  ConsumerState<IntegrationCheckupScreen> createState() =>
      _IntegrationCheckupScreenState();
}

class _IntegrationCheckupScreenState extends ConsumerState<IntegrationCheckupScreen> {
  final _systolicCtrl = TextEditingController();
  final _diastolicCtrl = TextEditingController();
  final _pulseCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _visitType = 'routine';
  String _captureLocation = 'community_event';
  bool _saving = false;

  @override
  void dispose() {
    _systolicCtrl.dispose();
    _diastolicCtrl.dispose();
    _pulseCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  int? _parseInt(String value) =>
      value.isNotEmpty ? int.tryParse(value) : null;

  Future<void> _save() async {
    if (_saving) return;

    final systolic = _parseInt(_systolicCtrl.text);
    final diastolic = _parseInt(_diastolicCtrl.text);
    if (systolic == null && diastolic == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter at least one BP reading.')),
      );
      return;
    }

    final verification = await showModalBottomSheet<VisitVerificationResult>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const VisitVerificationSheet(),
    );
    if (verification == null || !verification.confirmed) return;

    final patientId = ref.read(integrationPatientIdProvider);
    if (patientId == null) return;

    setState(() => _saving = true);
    try {
      final risk = RiskCalculator.calculate(
        RiskInput(systolicBp: systolic, diastolicBp: diastolic),
      );

      final vital = LocalVital()
        ..localId = const Uuid().v4()
        ..patientId = patientId
        ..systolicBp = systolic
        ..diastolicBp = diastolic
        ..pulse = _parseInt(_pulseCtrl.text)
        ..notes = [
          if (_notesCtrl.text.trim().isNotEmpty) _notesCtrl.text.trim(),
          'visit_type:$_visitType',
          if (verification.otpCode != null) 'otp:${verification.otpCode}',
        ].join('\n')
        ..syncStatus = SyncStatus.pending
        ..riskStatus = risk
        ..sourceType = 'chw_visit'
        ..captureLocationType = _captureLocation
        ..serviceLayer = 'physical_chw_visit'
        ..verificationMethod = verification.method.name
        ..verificationConfirmed = true
        ..createdAt = DateTime.now();

      await ref.read(isarServiceProvider).saveVital(vital);
      ref.read(syncServiceProvider).scheduleBackgroundSync();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkup saved — queued for sync')),
      );
      _systolicCtrl.clear();
      _diastolicCtrl.clear();
      _pulseCtrl.clear();
      _notesCtrl.clear();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IntegrationShell(
      title: 'Patient checkup',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Row(
            children: [
              Expanded(child: Text('Systolic BP (mmHg)')),
              YorubaPromptButton(assetFile: 'bp_systolic.mp3'),
            ],
          ),
          TextField(
            controller: _systolicCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: Text('Diastolic BP (mmHg)')),
              YorubaPromptButton(assetFile: 'bp_diastolic.mp3'),
            ],
          ),
          TextField(
            controller: _diastolicCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pulseCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Pulse (bpm)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notesCtrl,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const Divider(height: 32),
          Text('Visit type', style: Theme.of(context).textTheme.titleSmall),
          RadioGroup<String>(
            groupValue: _visitType,
            onChanged: (value) {
              if (value != null) setState(() => _visitType = value);
            },
            child: const Column(
              children: [
                RadioListTile<String>(title: Text('Routine'), value: 'routine'),
                RadioListTile<String>(title: Text('Follow-up'), value: 'follow_up'),
                RadioListTile<String>(title: Text('Urgent'), value: 'urgent'),
              ],
            ),
          ),
          const Divider(height: 24),
          Text('Location', style: Theme.of(context).textTheme.titleSmall),
          RadioGroup<String>(
            groupValue: _captureLocation,
            onChanged: (value) {
              if (value != null) setState(() => _captureLocation = value);
            },
            child: const Column(
              children: [
                RadioListTile<String>(title: Text('Home'), value: 'home'),
                RadioListTile<String>(
                  title: Text('Community event'),
                  value: 'community_event',
                ),
                RadioListTile<String>(title: Text('Clinic'), value: 'clinic'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Text(_saving ? 'Saving…' : 'Save checkup'),
                ),
              ),
              const YorubaPromptButton(assetFile: 'save_checkup.mp3'),
            ],
          ),
        ],
      ),
    );
  }
}
