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
      // For now, load a placeholder model or handle failure gracefully.
      // Once the actual model is trained, it should be placed in assets/models/
      _interpreter = await Interpreter.fromAsset('models/cycle_predictor.tflite');
      _isModelLoaded = true;
    } catch (e) {
      // Model not found or failed to load. We will use the fallback.
      _isModelLoaded = false;
      print('ML model not loaded, falling back to math engine. Error: $e');
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
        // 1. Prepare input tensor (e.g., last 6 cycle lengths, regularity score)
        // final input = _prepareInputTensor(periodDays);
        // 2. Run interpreter
        // final output = List.filled(1 * 3, 0).reshape([1, 3]); // e.g., nextStartOffset, confidence, range
        // _interpreter!.run(input, output);
        // 3. Process output and return CyclePrediction
        // ...
      } catch (e) {
        print('ML prediction failed, falling back to math engine. Error: $e');
      }
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
