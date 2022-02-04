import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tflite/tflite.dart';

// [과일인식 페이지]
// 야채 Tfile 만 loadModel()로 받아 온다.

class Fruits extends StatefulWidget {
  final List<CameraDescription> camera;
  const Fruits({Key? key, required this.camera}) : super(key: key);

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  String? resource;
  double index = 2;
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

  // Fruits 모델은 따로 학습시켜야함.

  Future<void> loadTfliteModel() async {
    if (mounted) {
      resource = await Tflite.loadModel(
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
    super.dispose();
    loadTfliteModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: LinearProgressIndicator(
                                      // 실제 프로그래스 색상.
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Colors.lightGreen,
                                      ),
                                      // 해당 하는 confidence 값을 받아서 표현함.
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
                                        '${index == 0 ? (confidence * 100).toStringAsFixed(2) : 0.0} %',
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
                                      value:
                                          index == 1 ? confidenceSecond : 0.0,

                                      backgroundColor: Colors.grey[200],
                                      minHeight: 50.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 1 ? (confidenceSecond * 100).toStringAsFixed(2) : 0.0} %',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
