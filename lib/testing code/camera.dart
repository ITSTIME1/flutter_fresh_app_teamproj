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
typedef Callback = void Function(List<dynamic> list);

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
        CameraController(widget.cameras.first, ResolutionPreset.medium);
    _cameraController.initialize().then((value) {
      // 마운트가 되지 않았다면 즉 카메라가 연결이 되지 않았다면
      if (!mounted) {
        return const CircularProgressIndicator();
      }
      setState(() {
        _cameraController.startImageStream((image) {
          if (!isReady) {
            isReady = true;
            Tflite.runModelOnFrame(
              bytesList: image.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: image.height,
              imageWidth: image.width,
              numResults: 4,
            ).then((value) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: 300,
                width: 500,
                child: CameraPreview(_cameraController),
              ),
            ),
          ],
        ),
      );
    }
  }
}
