import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

// [TeachableMachine Testing Code]
// python + colab => CNN 인공학습망
// Teachablemachine => Yolo + pix2pix 학습망.(CNN포함)

// Python 을 이용시에 가장 우선순위는 서버단을 따로 구축하지 않고
// Tflite 모델로 만드는것 입니다. Flutter 내부에서 동작하려면 가장 최적의 상태입니다.
// 만약 Tflite 집합셋으로 구축되지 않을경우, Flask 혹은 DJango를 활용해서 서버단을 간단하게 구축하고
// 서버단에서 신경망 학습을 시킵니다.
// 추가적으로

// 1. 본 모델에서는 아래와 같은 사실들을 입증하는 작업을 진행합니다.

// (1) 객체를 정확하게 인식하는가?
// (2) 객체의 데이터가 많아도 학습이 정확하게 이루어 지는가?
// (3) 학습시킨 데이터를 바탕으로 채소라면 상했는지 상하지 않았는지를 판별해 => 추천과 비추천을 정확하게 나눌 수 있는가?
// (4) loadModel()파일로 학습시킨 TensorFlow 데이터 이외에 데이터를 감지하면 null 값의 이미지를 리턴하는가?
// (5) 스크린샷을 통해 퍼센티지로 나오는 데이터를 캐치할 수 있는가?
// (6) 리스트 기능을 활용하여 스크린샷을 담을 수 있는가?
// (7) 각 라벨마다 '정보'와 '이미지'가 보여지는지 => Dialog 형식적용
// => '사과'를 분석하고 있다면, 그 사과가 어떤 기준을 갖고 데이터를 도출해 냈는지의 대한 이미지와 정보를 보여줍니다.
// => 'JSON방식의 정보' 와 + '어떤 데이터 파일을 썼는지' 를 보여줍니다.

// 2. 본 모델은 두 가지 기술을 방향성을 가지고 테스트 합니다.

// (1) python CNN 방식으로 학습시킨 데이터를 가지고 tfile set을 만들어 사용합니다.
// (2) TeachableMachine 구글에서 데이터 신경망 학습 시스템을 활용하여 tfile set을 만들어 활용합니다.

// 3. 테스트 결과 성능의 차이가 우위에 있는 기술로 적용합니다.

typedef Callback = void Function(List<dynamic> list);

class Teach extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  const Teach({Key? key, required this.cameras, required this.setRecognitions})
      : super(key: key);

  @override
  _TeachState createState() => _TeachState();
}

class _TeachState extends State<Teach> {
  late final CameraController _cameraController;
  // 카메라 감지 온 오프
  bool isDetecting = false;

  // 카메라가 실행이 될때 생명주기.

  @override
  void initState() {
    super.initState();

    // Camera 를 생성하여 _cameracontroller에 저장.
    _cameraController =
        CameraController(widget.cameras.first, ResolutionPreset.high);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      _cameraController.startImageStream((image) {
        if (!isDetecting) {
          isDetecting = true;
          Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) {
              return plane.bytes;
            }).toList(),
            imageHeight: image.height,
            imageWidth: image.width,
            numResults: 1,
          ).then((value) {
            if (value!.isNotEmpty) {
              widget.setRecognitions(value);
              isDetecting = false;
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _cameraController 가 정상적으로 초기화가 진행되지 않았다면
    // CircularProgressIndicator를 만든다.
    // 이 부분은 미팅을 통해서 어떻게 표시할지 상의한다.
    if (!_cameraController.value.isInitialized) {
      return const CircularProgressIndicator();
    }
    return Transform.scale(
      scale: 1 / _cameraController.value.aspectRatio,
      // 카메라 미리보기.
      // Stack으로 반환 한 이유는 체크박스가 필요할 수 있기 때문이다.
      // 만약 check박스가 필요하다면 displayBoxesAroundRecognizedObjects 를 사용한다.
      child: Stack(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio: _cameraController.value.aspectRatio,
              child: CameraPreview(_cameraController),
            ),
          ),
        ],
      ),
    );
  }
}
