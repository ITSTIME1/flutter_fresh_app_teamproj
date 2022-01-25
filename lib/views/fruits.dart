import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

// [과일인식 페이지]
// 야채 Tfile 만 loadModel()로 받아 온다.

class Fruits extends StatefulWidget {
  final List<CameraDescription> cameras;
  const Fruits({Key? key, required this.cameras}) : super(key: key);

  @override
  State<Fruits> createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  String predOne = '';
  double confidence = 0;
  double index = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadTfliteModel() async {
    String? res;
    res = await Tflite.loadModel(
      model: 'lib/assets/model_unquant.tflite',
      labels: "lib/assets/labels.txt",
    );
  }

  // Recognitions Function
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
      appBar: AppBar(
        elevation: 0.0,
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
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.orange[200],
        centerTitle: true,
        title: const Text(
          'FRUITS',
          style: TextStyle(
            fontFamily: 'Sairafont',
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 화면 상단 부분 카메라가 들어갈 박스.
          Stack(
            children: [
              Container(
                height: 300,
                width: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
              ),
              // Camera(
              //   setRecognitions: setRecognitions,
              //   cameras: widget.cameras,
              // ),
            ],
          ),

          // TensorFlow Model UI
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // First Value UI
                        Row(
                          children: [
                            // Text 부분
                            const Expanded(
                              flex: 2,
                              child: Text(
                                '테스트',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Expanded(
                              flex: 8,
                              child: SizedBox(
                                height: 32.0,
                                child: Stack(
                                  children: [
                                    // TensorFlow Model 값에 의해서 변경되는 부분.
                                    LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.redAccent),
                                      value: index == 0 ? confidence : 0.0,
                                      backgroundColor:
                                          Colors.redAccent.withOpacity(0.3),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 0 ? (confidence * 100).toStringAsFixed(0) : 0} %',
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

                        // Second Value UI
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                '테스트',
                                style: TextStyle(
                                    color: Colors.orangeAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
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
                                      backgroundColor:
                                          Colors.orangeAccent.withOpacity(0.2),
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
                        const SizedBox(
                          height: 16.0,
                        ),

                        // Third Value UI
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                '테스트',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
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
                                              Colors.blueAccent),
                                      value: index == 1 ? confidence : 0.0,
                                      backgroundColor:
                                          Colors.blueAccent.withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 2 ? (confidence * 100).toStringAsFixed(0) : 0} %',
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

                        // Fourth Value UI
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                '테스트',
                                style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
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
                                              Colors.greenAccent),
                                      value: index == 1 ? confidence : 0.0,
                                      backgroundColor:
                                          Colors.greenAccent.withOpacity(0.2),
                                      minHeight: 50.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${index == 2 ? (confidence * 100).toStringAsFixed(0) : 0} %',
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
                          height: 25.0,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
