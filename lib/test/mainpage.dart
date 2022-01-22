import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/test/testing.dart';
import 'package:tflite/tflite.dart';

class LoadModel extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const LoadModel({Key? key, this.cameras}) : super(key: key);

  @override
  _LoadModelState createState() => _LoadModelState();
}

class _LoadModelState extends State<LoadModel> {
  String predOne = '';
  double confidence = 0;
  double index = 0;

  List<CameraDescription>? get cameras => widget.cameras;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  // load TensorFlow Model
  // import lables and model recognition data set

  loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: 'lib/data/model/model_unquant.tflite',
      labels: 'lib/data/model/labels.txt',
    );
  }

  // recognition
  setRecognitions(outputs) {
    // checking outputs
    if (kDebugMode) {
      print(outputs);
    }

    if (outputs[0]['index'] == 0) {
      index = 0;
    } else {
      index = 1;
    }

    confidence = outputs[0]['confidence'];

    setState(() {
      // lable 을 계속해서 업데이트 해줌.
      predOne = outputs[0]['label'];
    });
  }

  // 카메라와 tflite 모델을 같이 불러오는 UI 부분
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TensorFlow app Testing'),
        backgroundColor: Colors.blueAccent,
      ),

      // Stack 을 활용해서 카메라 기능을 가장 위에 올려둔다.
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            setRecognitions,
          ),
        ],
      ),
    );
  }
}
