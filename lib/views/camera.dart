import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

// [Camera]
// 카메라를 초기화하고 이미지를 Frame 단위로 불러옵니다.
// setRecognition 값으로 넘겨주고 인식을 처리하는 부분은 각 페이지에서 담당합니다.

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
    if (mounted) {
      initCamera();
    }
  }

  // 카메라 초기화
  initCamera() {
    try {
      _cameraController = CameraController(
        widget.camera.first,
        ResolutionPreset.medium,
        // Image format
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
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
              (image) async {
                try {
                  if (!isDetecting) {
                    isDetecting = true;
                    Future.delayed(Duration(milliseconds: 560), () async {
                      await Tflite.runModelOnFrame(
                        bytesList: image.planes.map((plane) {
                          return plane.bytes;
                        }).toList(),
                        rotation: 90,
                        imageHeight: image.height,
                        imageWidth: image.width,
                        imageMean: 127.5,
                        imageStd: 127.5,
                        threshold: 0.1,
                        numResults: 5,
                        asynch: true,
                      ).then((value) {
                        if (value!.isNotEmpty) {
                          // value 값이 비어있지 않다면 인식시작
                          // value 값을 넘겨줌 setRecognition
                          widget.setRecognition(value);
                          isDetecting = false;
                          // 인식하는 부분을 불러옴
                        }
                      });
                    });
                  }
                } catch (e) {
                  print(e);
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
    // cameraController 가 초기화 되지 않았을때
    if (!_cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(
      children: [
        // customPaint 를 통해서 CameraPreview 를 보여줌.
        CameraPreview(
          _cameraController,
        ),
      ],
    );
  }
}
