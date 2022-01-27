import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tflite/tflite.dart';

// [야채인식 페이지]

// 야채 Tfile 만 loadModel()로 받아 온다.

// ignore: must_be_immutable
class Vegetable extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Vegetable({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Vegetable> createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
  // 결과값
  String predOne = '';
  // loadModel Value
  String? res;

  // 예측값
  double confidence = 0;

  double index = 0;

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

  // [Recognition Function]

  Future<dynamic> setRecognitions(outputs) async {
    // Outputs index == 0 이라면 index = 0
    // index 별로 if문 실행.
    if (mounted) {
      if (outputs[0]['index'] == 0) {
        index = 0;
        confidence = outputs[0]['confidence'];
      } else if (outputs[0]['index'] == 1) {
        index = 1;
        confidence = outputs[0]['confidence'];
      }

      setState(() {
        predOne = outputs[0]['label'];
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
      // [AppBar]

      // AppBar 디자인 부분은 미팅 이후 변경.
      // appBar: AppBar(
      //   elevation: 0.0,
      //   actions: [
      //     Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       // ignore: prefer_const_literals_to_create_immutables
      //       children: [
      //         const Padding(
      //           padding: EdgeInsets.only(right: 18.0),
      //           child: Icon(
      //             Icons.menu,
      //             size: 25,
      //             color: Colors.white,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      //   backgroundColor: Colors.teal[200],
      //   centerTitle: true,
      //   title: const Text(
      //     'TESTING',
      //     style: TextStyle(
      //       fontFamily: 'Sairafont',
      //       fontSize: 25,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      // body 부분은 가장 위에 카메라가 올려지고 그 이후에 다른 UI적 요소가 올라갑니다.

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
                                      value: index == 0 ? confidence : 0.0,
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
                                        '${index == 0 ? (confidence * 100).toStringAsFixed(2) : 0} %',
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
                                '괜찮아요',
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
                                      value: index == 1 ? confidence : 0.0,
                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 1 ? (confidence * 100).toStringAsFixed(2) : 0} %',
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
                      // Third Data UI

                      // Row(
                      //   // ignore: prefer_const_literals_to_create_immutables
                      //   children: [
                      //     const Expanded(
                      //       flex: 3,
                      //       // Need Padding
                      //       child: Padding(
                      //         padding: EdgeInsets.only(left: 15.0),
                      //         child: Text(
                      //           '좋지않아요',
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
                      // const SizedBox(
                      //   height: 16.0,
                      // ),

                      // // Last Data UI

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
