import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

typedef Callback = void Function(List<dynamic> list);

class Camera extends StatefulWidget {
  final List<CameraDescription>? cameras;
  final Callback setRecognitions;

  const Camera(this.cameras, this.setRecognitions, {Key? key})
      : super(key: key);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController _cameraController;
  bool isDetecting = false;

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
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const CircularProgressIndicator();
    }

    return Transform.scale(
      scale: 1 / _cameraController.value.aspectRatio,
      child: Center(
        child: AspectRatio(
          aspectRatio: _cameraController.value.aspectRatio,
          child: CameraPreview(_cameraController),
        ),
      ),
    );
  }
}
