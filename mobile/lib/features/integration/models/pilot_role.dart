enum PilotRole { chw, sponsor, coordinator }

extension PilotRoleX on PilotRole {
  String get storageKey => name;

  static PilotRole fromStorage(String? value) {
    if (value == 'admin') return PilotRole.coordinator;
    return PilotRole.values.firstWhere(
      (r) => r.name == value,
      orElse: () => PilotRole.chw,
    );
  }

  String get homeRoute {
    switch (this) {
      case PilotRole.chw:
        return '/integration/checkup';
      case PilotRole.sponsor:
        return '/integration/sponsor';
      case PilotRole.coordinator:
        return '/integration/coordinator';
    }
  }

  String get title {
    switch (this) {
      case PilotRole.chw:
        return 'Community Health Worker';
      case PilotRole.sponsor:
        return 'Family Sponsor';
      case PilotRole.coordinator:
        return 'Care Coordinator';
    }
  }
}
