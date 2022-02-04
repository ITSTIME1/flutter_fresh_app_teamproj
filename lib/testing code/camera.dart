import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/views/paint.dart';
import 'package:tflite/tflite.dart';

typedef Callback = void Function(List<dynamic> list);

class Cameras extends StatefulWidget {
  final List<CameraDescription> camera;
  final Callback setRecognition;
  const Cameras({Key? key, required this.camera, required this.setRecognition})
      : super(key: key);

  @override
  _CamerasState createState() => _CamerasState();
}

class _CamerasState extends State<Cameras> {
  late CameraController _cameraController;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  // 카메라 초기화
  initCamera() {
    try {
      _cameraController =
          CameraController(widget.camera.first, ResolutionPreset.medium);
      _cameraController.initialize().then(
        (value) {
          // 만약 마운트가 되지 않았다면
          // 서클프로그래스를 보여주고
          if (!mounted) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            _cameraController.startImageStream(
              (image) {
                if (!isDetecting) {
                  isDetecting = true;
                  Tflite.runModelOnFrame(
                    bytesList: image.planes.map((e) {
                      return e.bytes;
                    }).toList(),
                    imageHeight: image.height,
                    imageWidth: image.width,
                    numResults: 20,
                  ).then((value) {
                    // 인식을 시작하는 부분
                    if (value!.isNotEmpty) {
                      // value 값이 비어있지 않다면 인식시작
                      // value 값을 넘겨줌 setRecognition
                      widget.setRecognition(value);
                      isDetecting = false;
                      // 인식하는 부분을 불러옴
                    }
                  });
                }
              },
            );
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        CustomPaint(
          foregroundPainter: Painter(),
          child: CameraPreview(
            _cameraController,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: Clip(),
              child: CameraPreview(_cameraController),
            ),
          ],
        ),
      ],
    );
  }
}
