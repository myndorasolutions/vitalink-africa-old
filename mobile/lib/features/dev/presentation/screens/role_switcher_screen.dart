import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants.dart';
import '../../models/dev_role.dart';
import '../../providers/dev_role_provider.dart';
import '../widgets/role_preview_panel.dart';

class RoleSwitcherScreen extends ConsumerStatefulWidget {
  const RoleSwitcherScreen({super.key});

  @override
  ConsumerState<RoleSwitcherScreen> createState() => _RoleSwitcherScreenState();
}

class _RoleSwitcherScreenState extends ConsumerState<RoleSwitcherScreen> {
  bool _signingIn = false;
  bool _showAdvanced = false;
  late final TextEditingController _tokenCtrl;
  late final TextEditingController _patientIdCtrl;

  @override
  void initState() {
    super.initState();
    _tokenCtrl = TextEditingController(
      text: AppConstants.defaultPlaytestChwToken,
    );
    _patientIdCtrl = TextEditingController(
      text: AppConstants.defaultPlaytestPatientId,
    );
  }

  @override
  void dispose() {
    _tokenCtrl.dispose();
    _patientIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _continueAsRole() async {
    if (_signingIn) return;
    final role = ref.read(devRoleProvider);
    setState(() => _signingIn = true);
    try {
      if (_showAdvanced && role == DevRole.chw) {
        await ref.read(devRoleProvider.notifier).signInWithToken(
              token: _tokenCtrl.text.trim(),
              patientId: _patientIdCtrl.text.trim(),
            );
      } else {
        await ref.read(devRoleProvider.notifier).signInAs(role);
      }
      if (!mounted) return;
      context.go(role.homeRoute);
    } finally {
      if (mounted) setState(() => _signingIn = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedRole = ref.watch(devRoleProvider);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/myndora_care_logo5.jpeg',
              height: 72,
              errorBuilder: (_, _, _) =>
                  const Icon(Icons.health_and_safety, size: 72),
            ),
            const SizedBox(height: 16),
            Text(
              'Myndora Care',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Developer role switcher — pilot closed testing',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            Text(
              'Select role',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            ...DevRole.values.map(
              (role) => _RoleCard(
                role: role,
                selected: selectedRole == role,
                onTap: () => ref.read(devRoleProvider.notifier).select(role),
              ),
            ),
            RolePreviewPanel(role: selectedRole),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _signingIn ? null : _continueAsRole,
              child: Text(
                _signingIn
                    ? 'Signing in…'
                    : 'Continue as ${selectedRole.title}',
              ),
            ),
            const SizedBox(height: 16),
            ExpansionTile(
              title: const Text('Advanced (dev token)'),
              onExpansionChanged: (v) => setState(() => _showAdvanced = v),
              children: [
                TextField(
                  controller: _tokenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Mock Bearer token',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _patientIdCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Patient id',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.selected,
    required this.onTap,
  });

  final DevRole role;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: selected
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(role.icon, size: 32),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        role.subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (selected)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
