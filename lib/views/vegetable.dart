import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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

  int? index;
  double confidence = 0;
  double confidenceSecond = 0;
  double confidenceThird = 0;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        loadModel.loadVegetableModel();
      });
    }
    super.initState();
  }

  // 인식 함수.
  setRecognitions(outputs) {
    print(outputs);

    // [{confidence: 0.1245125, index = 1, label = '추천해요'}]

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
            minHeight: 200,
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
              Icons.keyboard_arrow_up_sharp,
              color: Colors.grey,
              size: 35,
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
              Recommend(confidence: confidence, index: index),
              SizedBox(
                height: MediaQuery.of(context).size.height / 45,
              ),

              // NotRecommend 인식 클래스
              NotRecommend(confidenceSecond: confidenceSecond, index: index),
              SizedBox(
                height: MediaQuery.of(context).size.height / 45,
              ),
              // Third Data UI

              // Another 인식 클래스
              Another(index: index, confidenceThird: confidenceThird),
              SizedBox(
                height: MediaQuery.of(context).size.height / 70,
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
  const Recommend({Key? key, required this.confidence, required this.index})
      : super(key: key);

  final double confidence;
  final int? index;

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
              width: MediaQuery.of(context).size.width / 15,
              height: MediaQuery.of(context).size.height / 15,
              child: Image.asset('lib/images/salad.png'),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 30,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Neumorphic(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: NeumorphicProgress(
                        percent: index == 0 ? confidence : 0,
                        height: 30,
                        style: ProgressStyle(
                          accent: Colors.green,
                          variant: Colors.white,
                        ),
                      ),
                      // child: LinearProgressIndicator(
                      //   // 변경되는 색상.
                      //   valueColor: AlwaysStoppedAnimation<Color>(
                      //     (Colors.green[800])!,
                      //   ),
                      //   value: index == 0 ? confidence : 0.0,
                      //   backgroundColor: Colors.green.withOpacity(0.4),
                      //   minHeight: 50,
                      // ),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: index == 0 ? 20 : 17,
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
    required this.index,
  }) : super(key: key);

  final double confidenceSecond;
  final int? index;
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
              width: MediaQuery.of(context).size.width / 15,
              height: MediaQuery.of(context).size.height / 15,
              child: Image.asset('lib/images/RottenSalad.png'),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 30,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Neumorphic(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: NeumorphicProgress(
                        percent: index == 1 ? confidenceSecond : 0,
                        height: 30,
                        style: ProgressStyle(
                          accent: Colors.green,
                          variant: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${(confidenceSecond * 100).toStringAsFixed(1)} %',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: index == 2 ? 20 : 17,
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
              width: MediaQuery.of(context).size.width / 15,
              height: MediaQuery.of(context).size.height / 15,
              child: Image.asset('lib/images/sad.png'),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 30,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Neumorphic(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: NeumorphicProgress(
                        percent: index == 2 ? confidenceThird : 0.0,
                        height: 30,
                        style: ProgressStyle(
                          accent: Colors.green,
                          variant: Colors.white,
                        ),
                      ),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: index == 2 ? 20 : 17,
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
