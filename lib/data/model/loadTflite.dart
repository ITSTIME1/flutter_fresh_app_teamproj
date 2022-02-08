import 'package:flutter/foundation.dart';
import 'package:tflite/tflite.dart';

class LoadModel {
  Future<void> loadTfliteModel() async {
    final String? resource;
    try {
      resource = await Tflite.loadModel(
        model: 'lib/assets/model_unquant.tflite',
        labels: "lib/assets/labels.txt",
        useGpuDelegate: true,
        numThreads: 5,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
