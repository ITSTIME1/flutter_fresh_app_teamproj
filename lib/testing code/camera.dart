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
  final List<CameraDescription>? cameras;
  final Callback? setRecognitions;
  const Camera({Key? key, this.setRecognitions, this.cameras})
      : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

// CameraState
class _CameraState extends State<Camera> {
  late CameraController _cameraController;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameras![0], ResolutionPreset.high);
    _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});

      _cameraController.startImageStream((image) {
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
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Camera 초기화 되지 않았을때 보여줄 UI.
    if (_cameraController.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return AspectRatio(
      aspectRatio: _cameraController.value.aspectRatio,
      child: CameraPreview(_cameraController),
    );
  }
}
