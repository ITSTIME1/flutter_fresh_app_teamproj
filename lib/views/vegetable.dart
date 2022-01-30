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
  List<int>? index = [];
  double? confidence;

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

  // setRecognitions(outputs) {
  //   if (_currentRecognitions.isNotEmpty) {
  //     setState(() {
  //       _currentRecognitions = outputs;
  //     });
  //   } else {
  //     const CircularProgressIndicator();
  //   }
  // }
  setRecognitions(outputs) {
    print(outputs);
    if (mounted) {
      // if (outputs[0]['index'] == 0 ||
      //     outputs[0]['index'] == 1 ||
      //     outputs[0]['index'] == 2) {
      //   index = outputs[0]['index'];
      //   confidence = outputs[0]['confidence'];
      // }

      // [로직 해석]
      // 만약 아웃풋에서 첫번째로 들어온 값의 index 가 0일경우
      // index 변수에 현재 outputs에서 출력되고 있는 outputs의 index 를 저장시키고 (후에 index 값이 참인지 거짓인지에 따라 인디케이터를 보여줄거임)
      // outputs에 있는 confidence는 frist, second, third 변수에 각각 따로 저장시켜 둔다.
      if (outputs[0]['index'] == 0 ||
          outputs[0]['index'] == 1 ||
          outputs[0]['index'] == 2) {
        index!.add(outputs[0]['index']);
        print(index);
        // [2,.2,2,2,2,2,]
        confidence = outputs[0]['confidence'];
      }
      setState(() {
        confidence;
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
                                      // value 값이 index 의 첫번째 값이라면 즉 추천해요 라는 값이 맞다면
                                      // confidence 값을 반환하고
                                      // 그렇지 않다면 0.0을 보여준다.
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
                                        '${index!.length > 0 ? (confidence! * 100).toStringAsFixed(2) : 0.0} %',
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
                                      value: confidence,

                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index!.length > 0 ? (confidence! * 100).toStringAsFixed(2) : 0.0} %',
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
                                      value: confidence,
                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index!.length > 0 ? (confidence! * 100).toStringAsFixed(2) : 0.0} %',
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
