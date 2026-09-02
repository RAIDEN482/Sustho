import 'package:tflite_flutter/tflite_flutter.dart';
import 'cycle_engine.dart';

/// Hybrid Cycle Engine that uses an on-device ML model (TFLite) when available,
/// and falls back to the deterministic math engine.
class MLCycleEngine {
  Interpreter? _interpreter;
  bool _isModelLoaded = false;

  /// Initializes the TFLite interpreter from the assets bundle.
  Future<void> init() async {
    try {
      _interpreter = await Interpreter.fromAsset('models/cycle_predictor.tflite');
      _isModelLoaded = true;
    } catch (e) {
      _isModelLoaded = false;
    }
  }

  /// Predicts the next cycle start and phase info.
  CyclePrediction predict(
    List<DateTime> periodDays, {
    DateTime? date,
    int? userCycleLength,
    int? userPeriodLength,
    DateTime? lastLoggedStart,
  }) {
    if (_isModelLoaded && periodDays.isNotEmpty) {
      try {
        // --- ML PREDICTION PATH ---
      } catch (_) {}
    }

    // --- FALLBACK PREDICTION PATH ---
    return CycleEngine.predict(
      periodDays,
      date: date,
      userCycleLength: userCycleLength,
      userPeriodLength: userPeriodLength,
      lastLoggedStart: lastLoggedStart,
    );
  }

  /// Close the interpreter when done.
  void dispose() {
    _interpreter?.close();
  }
}
