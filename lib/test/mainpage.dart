import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraUI extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraUI({Key? key, required this.cameras}) : super(key: key);

  @override
  _CameraUIState createState() => _CameraUIState();
}

class _CameraUIState extends State<CameraUI> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
