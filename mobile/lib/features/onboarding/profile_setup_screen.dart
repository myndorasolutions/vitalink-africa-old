import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../providers/app_providers.dart';
import '../../routing/app_router.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  String _gender = 'female';
  String _city = 'Lagos';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tell us about yourself',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: (v) =>
                    v != null && v.isNotEmpty ? null : 'Name is required',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageCtrl,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (v) => v != null && int.tryParse(v) != null
                    ? null
                    : 'Enter your age',
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: const [
                  DropdownMenuItem(value: 'female', child: Text('Female')),
                  DropdownMenuItem(value: 'male', child: Text('Male')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (v) => setState(() => _gender = v ?? 'female'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _city,
                decoration: const InputDecoration(labelText: 'City'),
                items: const [
                  DropdownMenuItem(value: 'Lagos', child: Text('Lagos')),
                  DropdownMenuItem(value: 'Abuja', child: Text('Abuja')),
                  DropdownMenuItem(value: 'Ibadan', child: Text('Ibadan')),
                  DropdownMenuItem(value: 'Kano', child: Text('Kano')),
                ],
                onChanged: (v) => setState(() => _city = v ?? 'Lagos'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final prefs = ref.read(sharedPreferencesProvider);
                  await prefs.setString(
                    AppConstants.prefsUserName,
                    _nameCtrl.text,
                  );
                  await prefs.setString(
                    AppConstants.prefsPatientId,
                    'local-${DateTime.now().millisecondsSinceEpoch}',
                  );
                  if (context.mounted) context.go(AppRoutes.consent);
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
