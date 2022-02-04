import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/loadTflite.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:fresh_app_teamproj/views/paint.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// [Vegetable]

// 야채에 관련된 dataSet 만 loadModel()로 받아 온다.
// ignore: must_be_immutable
class Vegetable extends StatefulWidget {
  final List<CameraDescription> camera;
  const Vegetable({Key? key, required this.camera}) : super(key: key);

  @override
  State<Vegetable> createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
  final LoadModel loadModel = LoadModel();

  int? index;
  double confidence = 0;
  double confidenceSecond = 0;
  double confidenceThird = 0;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        loadModel.loadTfliteModel();
      });
    }
    super.initState();
  }

  setRecognitions(outputs) {
    if (mounted) {
      // outputs에 처음 들어온 index 값이 0이라면
      // 각각 confidence 에 예측값 대입.
      if (outputs[0]['index'] == 0) {
        index = 0;
        confidence = outputs[0]['confidence'];
        // outputs에 처음 들어온 index 값이 1 이라면
      } else if (outputs[0]['index'] == 1) {
        index = 1;
        confidenceSecond = outputs[0]['confidence'];
        // outputs에 처음 들어온 index 값이 2 이라면
      } else if (outputs[0]['index'] == 2) {
        index = 2;
        confidenceThird = outputs[0]['confidence'];
      }
      setState(() {
        confidence;
        confidenceSecond;
        confidenceThird;
      });
    } else {
      const CircularProgressIndicator();
    }
  }

  @override
  void dispose() async {
    loadModel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Cameras(
            camera: widget.camera,
            setRecognition: setRecognitions,
          ),
          SlidingUpPanel(
            maxHeight: 250,
            minHeight: 200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            panel: Stack(
              children: [
                // First Data UI
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Icon(
                      Icons.drag_handle_rounded,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First value
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Expanded(
                            flex: 4,
                            // Need Padding
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Recommend',
                                style: TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            flex: 6,
                            child: SizedBox(
                              height: 32.0,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      // % 숫자
                                      child: Text(
                                        '${(confidence * 100).toStringAsFixed(1)} %',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // Second Data UI

                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Expanded(
                            flex: 3,
                            // Need Padding
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'NotRecommend',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: 32.0,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${(confidenceSecond * 100).toStringAsFixed(1)} %',
                                        style: TextStyle(
                                          color: Colors.green[200],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      // Third Data UI

                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Expanded(
                            flex: 3,
                            // Need Padding
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                'Another',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            flex: 7,
                            child: SizedBox(
                              height: 32.0,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 2 ? (confidenceThird * 100).toStringAsFixed(1) : 0.0} %',
                                        style: TextStyle(
                                            color: Colors.green[100],
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
