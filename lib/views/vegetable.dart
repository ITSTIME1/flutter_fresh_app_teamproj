import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/testing%20code/camera.dart';
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
  // 예측값
  double confidence = 0;

  double index = 0;

  @override
  void initState() {
    super.initState();
    loadTfliteModel();
  }

  // TensorfliteModel Function
  Future<void> loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: 'lib/assets/model_unquant.tflite',
      labels: "lib/assets/labels.txt",
    );
  }

  // recognition function

  // setstate
  setRecognitions(outputs) {
    if (outputs[0]['index'] == 0) {
      index = 0;
      index = 1;
    }
    // 예측값저장.
    confidence = outputs[0]['confidence'];

    setState(() {
      predOne = outputs[0]['label'];
    });
  }

  @override
  void dispose() {
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Apple',
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 32.0,
                                  child: Stack(
                                    children: [
                                      LinearProgressIndicator(
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.redAccent),
                                        value:
                                            index == 0 & 1 ? confidence : 0.0,
                                        backgroundColor:
                                            Colors.redAccent.withOpacity(0.2),
                                        minHeight: 50.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${index == 0 ? (confidence * 100).toStringAsFixed(2) : 0} %',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                flex: 2,
                                child: Text(
                                  'Orange',
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.0),
                                ),
                              ),
                              const SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                flex: 8,
                                child: SizedBox(
                                  height: 32.0,
                                  child: Stack(
                                    children: [
                                      LinearProgressIndicator(
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                                Colors.orangeAccent),
                                        value: index == 1 ? confidence : 0.0,
                                        backgroundColor: Colors.orangeAccent
                                            .withOpacity(0.2),
                                        minHeight: 50.0,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${index == 1 ? (confidence * 100).toStringAsFixed(0) : 0} %',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
