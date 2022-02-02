import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

// [Camera Function]
// 카메라를 핸들링 하는 페이지 입니다.
// 카메라를 보여주는것, 카메라의 이미지 저장, 갤러리, 화면 바꾸기, 갤러에서 이미지 가져오기 등
// 전반적으로 카메라의 기능을 대표하는 페이지입니다.

// 추가적으로 Tflite TensorFlow 파일들을 frame 단위로 가지고와서 인식을 시작합니다.
// 코드리뷰는 추후에 완벽하게 정리가된 후에 작성하도록 하겠습니다.

// setRecognition function callback
typedef Callback = void Function(List<dynamic>);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback? setRecognitions;
  const Camera({Key? key, required this.cameras, this.setRecognitions})
      : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

// CameraState
class _CameraState extends State<Camera> with TickerProviderStateMixin {
  late CameraController _cameraController;
  late AnimationController _animationController;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    // CameraController => ResolutionPreset.low high 등 카메라의 화질을 나타냄.
    initCamera();
  }

  // Camera Initialize and StreamImage
  initCamera() {
    _cameraController =
        CameraController(widget.cameras.first, ResolutionPreset.ultraHigh);
    _cameraController.initialize().then((value) {
      // 마운트가 되지 않았다면 즉 카메라가 연결이 되지 않았다면
      // CircleIndicator를 UI에 보여줌.
      if (!mounted) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const CircularProgressIndicator(),
          ],
        );
      }
      // 화면이 연결 되었다면 화면에 나오는 image를 프레임단위로 받음.
      setState(() {
        _cameraController.startImageStream((image) {
          if (!isReady) {
            isReady = true;
            // Run on image stream (video frame)
            // toList 를 해주기 전까지 planes 리스트 값을 element 요소로 받아오면
            // Iterable 형태라 현재 필요한거 List 형태.
            Tflite.runModelOnFrame(
              bytesList: image.planes.map((element) {
                return element.bytes;
              }).toList(),
              imageHeight: image.height,
              imageWidth: image.width,
              numResults: 4,
            ).then((value) {
              // List로 만든 Frame 단위를 value로 가져오는데
              // 이때 List 값의 Null 체크를 위해서 비어 있지 않다면 이라는 if문을 가정한다.
              // 후에 반복문에서는 setRecognitions 라는 함수가 실행되게 되며 setRecognition(value) => 값은 List로 받은
              // 값을 value로 리턴한다. 그럼후에 outputs 값에 value 값이 들어가게 되는데
              // list [{}] maping 되어 있는 형태로 들어간다.

              if (value!.isNotEmpty) {
                widget.setRecognitions!(value);
                isReady = false;
              }
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // 카메라의 UI부분을 그리는 build Method 입니다.
  @override
  Widget build(BuildContext context) {
    // Camera 초기화 되지 않았을때 보여줄 UI.
    // Camera 부분만 빌드되는 것이기 때문에
    // Camera '사이즈' 부분만 수정 요구 됩니다.
    // Camera UI 가 보여지는 부분은 각각의 페이지에서 확인하면 됩니다.

    if (!_cameraController.value.isInitialized) {
      return Center(
        // camera가 초기화 되기까지 CircleIndicatior를 보여줌.
        // animation을 사용하여 indicator의 색상을 다이나믹 하게 변경함.
        child: CircularProgressIndicator(
          valueColor: _animationController.drive(
            ColorTween(
              begin: Colors.greenAccent,
              end: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 560,
              width: 500,
              child: CameraPreview(_cameraController),
            ),
          ],
        ),
      );
    }
  }
}
