import 'package:tflite/tflite.dart';

class LoadModel {
  loadTfliteModel() async {
    await Tflite.loadModel(
      model: 'lib/assets/ssd_mobilenet.tflite',
      labels: "lib/assets/ssd_mobilenet.txt",
      useGpuDelegate: true,
      numThreads: 5,
    );
  }
}
