/// Menstrual flow intensity.
enum FlowLevel {
  none(0),
  spotting(1),
  light(2),
  medium(3),
  heavy(4);

  const FlowLevel(this.value);
  final int value;

  static FlowLevel fromValue(int value) {
    return FlowLevel.values.firstWhere(
      (f) => f.value == value,
      orElse: () => FlowLevel.none,
    );
  }
}

/// Mood options a user can record for a day (8 presets + custom).
enum Mood {
  happy(0),
  calm(1),
  anxious(2),
  sad(3),
  irritable(4),
  energetic(5),
  tired(6),
  angry(7);

  const Mood(this.value);
  final int value;

  static Mood fromValue(int value) {
    return Mood.values.firstWhere(
      (m) => m.value == value,
      orElse: () => Mood.happy,
    );
  }
}

/// Physical/emotional symptoms a user can record for a day.
enum SymptomType {
  cramps(0),
  headache(1),
  backache(2),
  bloating(3),
  breastTenderness(4),
  fatigue(5),
  nausea(6),
  acne(7),
  craving(8),
  insomnia(9),
  moodSwings(10),
  anxiety(11);

  const SymptomType(this.value);
  final int value;

  static SymptomType fromValue(int value) {
    return SymptomType.values.firstWhere(
      (s) => s.value == value,
      orElse: () => SymptomType.cramps,
    );
  }
}

/// Where the pain is located (body map regions).
enum PainLocation {
  lowerAbdomen(0),
  lowerBack(1),
  upperBack(2),
  thighs(3),
  hips(4),
  head(5);

  const PainLocation(this.value);
  final int value;

  static PainLocation fromValue(int value) {
    return PainLocation.values.firstWhere(
      (p) => p.value == value,
      orElse: () => PainLocation.lowerAbdomen,
    );
  }
}

/// Menstrual product used on a day.
enum ProductUsed {
  none(0),
  pad(1),
  tampon(2),
  cup(3),
  underwear(4);

  const ProductUsed(this.value);
  final int value;

  static ProductUsed fromValue(int value) {
    return ProductUsed.values.firstWhere(
      (p) => p.value == value,
      orElse: () => ProductUsed.none,
    );
  }
}

/// Clot size option.
enum ClotSize {
  none(0),
  small(1),
  medium(2),
  large(3);

  const ClotSize(this.value);
  final int value;

  static ClotSize fromValue(int value) {
    return ClotSize.values.firstWhere(
      (c) => c.value == value,
      orElse: () => ClotSize.none,
    );
  }
}

/// Relief methods checklist.
enum ReliefMethod {
  heatPad(0),
  medication(1),
  herbalTea(2),
  rest(3),
  stretching(4),
  massage(5);

  const ReliefMethod(this.value);
  final int value;

  static ReliefMethod fromValue(int value) {
    return ReliefMethod.values.firstWhere(
      (r) => r.value == value,
      orElse: () => ReliefMethod.heatPad,
    );
  }
}
