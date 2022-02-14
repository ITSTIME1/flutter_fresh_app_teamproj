import 'package:tflite/tflite.dart';

class LoadModel {
  // Load TfliteModel();
  loadFruitsModel() async {
    await Tflite.loadModel(
      model: 'lib/assets/fruitsModel.tflite',
      labels: "lib/assets/fruitsModelLabel.txt",
      useGpuDelegate: true,
      numThreads: 5,
    );
  }

  loadVegetableModel() async {}
}
