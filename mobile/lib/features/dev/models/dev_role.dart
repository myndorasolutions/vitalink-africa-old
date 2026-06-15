import 'package:flutter/material.dart';

import '../../integration/models/pilot_role.dart';

enum DevRole { chw, sponsor, admin }

extension DevRoleX on DevRole {
  String get storageKey => name == DevRole.admin.name ? 'coordinator' : name;

  static DevRole fromStorage(String? value) {
    if (value == null) return DevRole.chw;
    if (value == 'coordinator' || value == 'admin') return DevRole.admin;
    return DevRole.values.firstWhere(
      (r) => r.name == value,
      orElse: () => DevRole.chw,
    );
  }

  PilotRole get toPilotRole {
    switch (this) {
      case DevRole.chw:
        return PilotRole.chw;
      case DevRole.sponsor:
        return PilotRole.sponsor;
      case DevRole.admin:
        return PilotRole.coordinator;
    }
  }

  String get homeRoute => toPilotRole.homeRoute;

  String get title {
    switch (this) {
      case DevRole.chw:
        return 'CHW';
      case DevRole.sponsor:
        return 'Sponsor';
      case DevRole.admin:
        return 'Admin';
    }
  }

  String get subtitle {
    switch (this) {
      case DevRole.chw:
        return 'Field checkups with Yoruba audio + visit verification';
      case DevRole.sponsor:
        return 'Pricing, CHW assignment, vitals monitoring';
      case DevRole.admin:
        return 'Trust grids, sync queue, clinician review';
    }
  }

  IconData get icon {
    switch (this) {
      case DevRole.chw:
        return Icons.medical_services_outlined;
      case DevRole.sponsor:
        return Icons.family_restroom;
      case DevRole.admin:
        return Icons.admin_panel_settings_outlined;
    }
  }
}
