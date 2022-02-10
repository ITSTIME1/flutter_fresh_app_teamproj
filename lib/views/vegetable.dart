import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/loadTflite.dart';
import 'package:fresh_app_teamproj/views/camera.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// [Vegetable]

// 야채에 관련된 dataSet 만 loadModel()로 받아 옵니다.
// 인식에 관련된 부분을 처리합니다.

// ignore: must_be_immutable
class Vegetable extends StatefulWidget {
  final List<CameraDescription> camera;
  const Vegetable({Key? key, required this.camera}) : super(key: key);

  @override
  State<Vegetable> createState() => _VegetableState();
}

class _VegetableState extends State<Vegetable> {
  final LoadModel loadModel = LoadModel();

  int? index = 0;

  // [confidence]
  // 각 예측값을 들어오기전 초기화

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
            maxHeight: 270,
            minHeight: 230,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            panel: SlidingMainWidget(
              confidence: confidence,
              confidenceSecond: confidenceSecond,
              index: index,
              confidenceThird: confidenceThird,
            ),
          )
        ],
      ),
    );
  }
}

class SlidingMainWidget extends StatelessWidget {
  const SlidingMainWidget({
    Key? key,
    required this.confidence,
    required this.confidenceSecond,
    required this.index,
    required this.confidenceThird,
  }) : super(key: key);

  final double confidence;
  final double confidenceSecond;
  final int? index;
  final double confidenceThird;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              const SizedBox(
                height: 10,
              ),

              // Recommend 인식 클래스
              Recommend(confidence: confidence),
              const SizedBox(
                height: 16.0,
              ),

              // NotRecommend 인식 클래스
              NotRecommend(confidenceSecond: confidenceSecond),
              const SizedBox(
                height: 16.0,
              ),
              // Third Data UI

              // Another 인식 클래스
              Another(index: index, confidenceThird: confidenceThird),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// [Recommend Class]
class Recommend extends StatelessWidget {
  const Recommend({
    Key? key,
    required this.confidence,
  }) : super(key: key);

  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          flex: 3,
          // Need Padding
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 13,
              height: MediaQuery.of(context).size.height / 13,
              child: Image.asset('lib/images/salad.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 25.0,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: LinearProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                      value: confidence,
                      backgroundColor: Colors.green.withOpacity(0.2),
                      minHeight: 50.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    // % 숫자
                    child: Text(
                      '${(confidence * 100).toStringAsFixed(1)} %',
                      style: const TextStyle(
                        color: Colors.white,
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
    );
  }
}

// [NotRecommend Class]
class NotRecommend extends StatelessWidget {
  const NotRecommend({
    Key? key,
    required this.confidenceSecond,
  }) : super(key: key);

  final double confidenceSecond;

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          flex: 3,
          // Need Padding
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 13,
              height: MediaQuery.of(context).size.height / 13,
              child: Image.asset('lib/images/RottenSalad.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 25.0,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        (Colors.green[200])!,
                      ),
                      value: confidenceSecond,
                      backgroundColor: Colors.green.withOpacity(0.2),
                      minHeight: 50.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${(confidenceSecond * 100).toStringAsFixed(1)} %',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// [Another Class]
class Another extends StatelessWidget {
  const Another({
    Key? key,
    required this.index,
    required this.confidenceThird,
  }) : super(key: key);

  final int? index;
  final double confidenceThird;

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          flex: 3,
          // Need Padding
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 20,
              height: MediaQuery.of(context).size.height / 20,
              child: Image.asset('lib/images/sad.png'),
            ),
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: 25.0,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: LinearProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                      value: confidenceThird,
                      backgroundColor: Colors.green.withOpacity(0.2),
                      minHeight: 50.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${index == 2 ? (confidenceThird * 100).toStringAsFixed(1) : 0.0} %',
                      style: TextStyle(
                        color: Colors.green[100],
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
