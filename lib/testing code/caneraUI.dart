import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:tflite/tflite.dart';

// UI 부분은 카메라를 가져옴.
class CameraUI extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraUI({Key? key, this.cameras}) : super(key: key);

  @override
  _CameraUIState createState() => _CameraUIState();
}

class _CameraUIState extends State<CameraUI> {
  String predOne = '';
  double confidence = 0;
  double index = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  // TensorFliteModel import
  Future<void> loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: "lib/data/model/model_unquant.tflite",
        labels: "lib/data/model/labels.txt");
  }

  setRecognitions(outputs) {
    if (outputs[0]['index'] == 0) {
      index = 0;
    } else {
      index = 1;
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "TensorFlow Lite App",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          Camera(
            cameras: widget.cameras,
            setRecognitions: setRecognitions,
          ),
        ],
      ),
    );
  }
}
