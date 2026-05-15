/// Mirrors [backend/internal/vitals/risk_engine.go].
class RiskThresholds {
  const RiskThresholds({
    this.systolicGreenMax = 139,
    this.diastolicGreenMax = 89,
    this.fastingGreenMax = 125.9,
    this.randomGreenMax = 199.9,
    this.systolicYellowMax = 179,
    this.diastolicYellowMax = 119,
    this.fastingYellowMax = 250,
    this.randomYellowMax = 299,
  });

  final int systolicGreenMax;
  final int diastolicGreenMax;
  final double fastingGreenMax;
  final double randomGreenMax;
  final int systolicYellowMax;
  final int diastolicYellowMax;
  final double fastingYellowMax;
  final double randomYellowMax;

  static const defaults = RiskThresholds();
}

class RiskInput {
  const RiskInput({
    this.systolicBp,
    this.diastolicBp,
    this.glucoseFasting,
    this.glucoseRandom,
    this.symptoms = const [],
  });

  final int? systolicBp;
  final int? diastolicBp;
  final double? glucoseFasting;
  final double? glucoseRandom;
  final List<String> symptoms;
}

class RiskCalculator {
  static String calculate(RiskInput input, [RiskThresholds t = RiskThresholds.defaults]) {
    if (_hasChestPain(input.symptoms) &&
        (input.systolicBp != null || input.diastolicBp != null)) {
      return 'red';
    }
    if (_isRedBp(input.systolicBp, input.diastolicBp) ||
        _isRedGlucose(input.glucoseFasting, input.glucoseRandom)) {
      return 'red';
    }
    if (_isYellowBp(input.systolicBp, input.diastolicBp, t) ||
        _isYellowGlucose(input.glucoseFasting, input.glucoseRandom, t)) {
      return 'yellow';
    }
    return 'green';
  }

  static String alertTypeForRisk(String risk, RiskInput input) {
    if (_isRedBp(input.systolicBp, input.diastolicBp)) return 'high_bp';
    if (_isRedGlucose(input.glucoseFasting, input.glucoseRandom)) {
      return 'high_glucose';
    }
    return 'symptom_escalation';
  }

  static bool _hasChestPain(List<String> symptoms) {
    return symptoms.any((s) => s.toLowerCase() == 'chest pain');
  }

  static bool _isRedBp(int? sys, int? dia) {
    if (sys != null && sys >= 180) return true;
    if (dia != null && dia >= 120) return true;
    return false;
  }

  static bool _isRedGlucose(double? fast, double? random) {
    if (fast != null && fast >= 300) return true;
    if (random != null && random >= 300) return true;
    return false;
  }

  static bool _isYellowBp(int? sys, int? dia, RiskThresholds t) {
    if (sys != null && sys >= 140 && sys <= t.systolicYellowMax) return true;
    if (dia != null && dia >= 90 && dia <= t.diastolicYellowMax) return true;
    return false;
  }

  static bool _isYellowGlucose(double? fast, double? random, RiskThresholds t) {
    if (fast != null && fast >= 126 && fast <= t.fastingYellowMax) return true;
    if (random != null && random >= 200 && random <= t.randomYellowMax) {
      return true;
    }
    return false;
  }
}
