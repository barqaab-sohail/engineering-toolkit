class PowerConverter {
  // kW to Ampere (single phase)
  static double kwToAmpsSinglePhase(
    double kw,
    double voltage, {
    double pf = 0.8,
  }) {
    return (kw * 1000) / (voltage * pf);
  }

  // Ampere to kW (single phase)
  static double ampsToKwSinglePhase(
    double amps,
    double voltage, {
    double pf = 0.8,
  }) {
    return (amps * voltage * pf) / 1000;
  }

  // kW to Ampere (three phase)
  static double kwToAmpsThreePhase(
    double kw,
    double voltage, {
    double pf = 0.8,
  }) {
    return (kw * 1000) / (voltage * pf * 1.732);
  }

  // Ampere to kW (three phase)
  static double ampsToKwThreePhase(
    double amps,
    double voltage, {
    double pf = 0.8,
  }) {
    return (amps * voltage * pf * 1.732) / 1000;
  }

  // Other common conversions
  static double hpToKw(double hp) => hp * 0.746;
  static double kwToHp(double kw) => kw / 0.746;
  static double btuToKw(double btu) => btu * 0.000293;
  static double kwToBtu(double kw) => kw / 0.000293;
}
