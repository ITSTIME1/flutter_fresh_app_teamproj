import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tflite/tflite.dart';

// [Vegetable]

// 야채에 관련된 dataSet 만 loadModel()로 받아 온다.
// ignore: must_be_immutable
class Vegetable extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Vegetable({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Vegetable> createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
  String? res;
  double index = 0;
  // 추천해요 confidence 값
  double confidence = 0;
  // 추천하지 않아요 confidence 값
  double confidenceSecond = 0;
  // 다른샘플 confidence 값
  double confidenceThird = 0;
  @override
  void initState() {
    if (mounted) {
      setState(() {
        loadTfliteModel();
      });
    }
    super.initState();
  }

  // [TensorfliteModel Function]

  Future<void> loadTfliteModel() async {
    if (mounted) {
      res = await Tflite.loadModel(
        model: 'lib/assets/model_unquant.tflite',
        labels: "lib/assets/labels.txt",
      );
    } else {
      const CircularProgressIndicator();
    }
  }

  //  [Recognition Function]

  // outputs = List value
  // outputs 처음으로 들어온 값 기준으로.
  setRecognitions(outputs) {
    if (mounted) {
      // outputs에 처음들어온 index 값이 0이라면
      if (outputs[0]['index'] == 0) {
        index = 0;
        confidence = outputs[0]['confidence'];
      } else if (outputs[0]['index'] == 1) {
        index = 1;
        confidenceSecond = outputs[0]['confidence'];
      } else if (outputs[0]['index'] == 2) {
        index = 2;
        confidenceThird = outputs[0]['confidence'];
      }
      print(index);
      print(outputs);
      print(confidence);
      print(confidenceSecond);
      print(confidenceThird);
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
    super.dispose();
    loadTfliteModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            cameras: widget.cameras,
            setRecognitions: setRecognitions,
          ),
          SlidingUpPanel(
            maxHeight: 260,
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
                            flex: 3,
                            // Need Padding
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                '추천해요',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
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
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LinearProgressIndicator(
                                      // 실제 프로그래스 색상.
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.lightGreen,
                                      ),
                                      // 해당 하는 confidence 값을 받아서 표현함.
                                      value: confidence,
                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      // % 숫자
                                      child: Text(
                                        '${(confidence * 100).toStringAsFixed(2)} %',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
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
                                '추천하지않아요',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
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
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LinearProgressIndicator(
                                      // 실제 프로그래스 색상.
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.orangeAccent,
                                      ),
                                      value: confidenceSecond,

                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${(confidenceSecond * 100).toStringAsFixed(2)} %',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.0,
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
                                '다른샘플..?',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
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
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: LinearProgressIndicator(
                                      // 실제 프로그래스 색상.
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.purple,
                                      ),
                                      value: index == 2 ? confidenceThird : 0.0,
                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 2 ? (confidenceThird * 100).toStringAsFixed(2) : 0.0} %',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0),
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

                      // Last Data UI

                      // Row(
                      //   // ignore: prefer_const_literals_to_create_immutables
                      //   children: [
                      //     const Expanded(
                      //       flex: 3,
                      //       // Need Padding
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 15.0),
                      //         child: Text(
                      //           '인식이..',
                      //           style: TextStyle(
                      //             fontSize: 18.0,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       height: 16.0,
                      //     ),
                      //     Expanded(
                      //       flex: 7,
                      //       child: SizedBox(
                      //         height: 32.0,
                      //         child: Stack(
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 10.0),
                      //               child: LinearProgressIndicator(
                      //                 // 실제 프로그래스 색상.
                      //                 valueColor:
                      //                     const AlwaysStoppedAnimation<Color>(
                      //                   Colors.lightGreen,
                      //                 ),
                      //                 value: index == 0 ? confidence : 0.0,
                      //                 backgroundColor: Colors.grey[200],
                      //                 minHeight: 50.0,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(right: 12.0),
                      //               child: Align(
                      //                 alignment: Alignment.centerRight,
                      //                 child: Text(
                      //                   '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                      //                   style: const TextStyle(
                      //                       color: Colors.white,
                      //                       fontWeight: FontWeight.w600,
                      //                       fontSize: 20.0),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
