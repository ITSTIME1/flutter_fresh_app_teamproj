import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

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
class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras;
  CameraController? _cameraController;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      // 사용가능한 카메라를 가져온다
      cameras = await availableCameras();
      _cameraController =
          CameraController(cameras![0], ResolutionPreset.medium);
      _cameraController!.initialize().then((value) {
        if (!mounted) {
          return;
        }
        setState(() {});

        _cameraController!.startImageStream((image) {
          if (!isReady) {
            isReady = true;
            Tflite.runModelOnFrame(
              bytesList: image.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: image.height,
              imageWidth: image.width,
              numResults: 1,
            ).then((value) {
              if (value!.isNotEmpty) {
                widget.setRecognitions!(value);
                isReady = false;
              }
            });
          }
        });
      });
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
    // 앱이 종료될때 같이 종료 될 수 있도록 한다.
    @override
    void dispose() {
      _cameraController?.dispose();
      super.dispose();
    }
  }

  // 만약 controller 가 초기화 되지 않았다면 CirclularIndicator만 그려줍니다.
  @override
  Widget build(BuildContext context) {
    if (_cameraController!.value.isInitialized) {
      return const CircularProgressIndicator();
    }
    // 카메라 비율을 조정할 수 있는 AspectRatio 내부에서 카메라 프리뷰를 보여준다.
    return AspectRatio(
      aspectRatio: _cameraController!.value.aspectRatio,
      child: CameraPreview(_cameraController!),
    );
  }
}
