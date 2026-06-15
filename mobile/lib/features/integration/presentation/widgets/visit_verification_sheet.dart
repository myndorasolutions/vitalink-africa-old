import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../widgets/signature_pad.dart';

enum VisitVerificationMethod { signature, manualOtp }

class VisitVerificationResult {
  const VisitVerificationResult({
    required this.method,
    required this.confirmed,
    this.otpCode,
  });

  final VisitVerificationMethod method;
  final bool confirmed;
  final String? otpCode;
}

class VisitVerificationSheet extends StatefulWidget {
  const VisitVerificationSheet({super.key});

  @override
  State<VisitVerificationSheet> createState() => _VisitVerificationSheetState();
}

class _VisitVerificationSheetState extends State<VisitVerificationSheet> {
  VisitVerificationMethod _method = VisitVerificationMethod.signature;
  bool _signatureReady = false;
  late final String _displayOtp;
  final _otpInputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayOtp = (Random().nextInt(9000) + 1000).toString();
  }

  @override
  void dispose() {
    _otpInputCtrl.dispose();
    super.dispose();
  }

  bool get _canConfirm {
    if (_method == VisitVerificationMethod.signature) {
      return _signatureReady;
    }
    return _otpInputCtrl.text.trim() == _displayOtp;
  }

  void _confirm() {
    Navigator.pop(
      context,
      VisitVerificationResult(
        method: _method,
        confirmed: true,
        otpCode: _method == VisitVerificationMethod.manualOtp ? _displayOtp : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Confirm visit completion',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SegmentedButton<VisitVerificationMethod>(
            segments: const [
              ButtonSegment(
                value: VisitVerificationMethod.signature,
                label: Text('Signature'),
                icon: Icon(Icons.draw),
              ),
              ButtonSegment(
                value: VisitVerificationMethod.manualOtp,
                label: Text('Manual OTP'),
                icon: Icon(Icons.pin),
              ),
            ],
            selected: {_method},
            onSelectionChanged: (value) {
              setState(() => _method = value.first);
            },
          ),
          const SizedBox(height: 16),
          if (_method == VisitVerificationMethod.signature)
            SignaturePad(onChanged: (ready) => setState(() => _signatureReady = ready))
          else ...[
            Text(
              'Tell the patient this code:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            SelectableText(
              _displayOtp,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _otpInputCtrl,
              decoration: const InputDecoration(
                labelText: 'Enter patient code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 4,
              onChanged: (_) => setState(() {}),
            ),
          ],
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _canConfirm ? _confirm : null,
            child: const Text('Confirm completion'),
          ),
        ],
      ),
    );
  }
}
