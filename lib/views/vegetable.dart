import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:tflite/tflite.dart';

// [야채인식 페이지]
// 야채 Tfile 만 loadModel()로 받아 온다.

class Vegetable extends StatefulWidget {
  const Vegetable({
    Key? key,
  }) : super(key: key);

  @override
  State<Vegetable> createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
  String predOne = '';
  double confidence = 0;
  double index = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  Future<void> loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
        model: 'lib/data/model/model_unquant.tflite',
        labels: "lib/data/mode/labels.txt");
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
      // AppBar 부분 디자인.
      // AppBar 디자인 부분은 미팅 이후 변경.
      appBar: AppBar(
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 18.0),
                child: Icon(
                  Icons.menu,
                  size: 25,
                ),
              ),
            ],
          ),
        ],
        backgroundColor: const Color.fromRGBO(238, 238, 238, 50),
        centerTitle: true,
        title: const Text(
          'VEGETABLE',
          style: TextStyle(
            fontFamily: 'Sairafont',
            fontSize: 25,
            color: Color.fromRGBO(0, 0, 0, 50),
          ),
        ),
      ),
      body: Stack(
        children: [
          Camera(),
        ],
      ),
    );
  }
}
