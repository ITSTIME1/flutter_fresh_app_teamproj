import 'package:flutter/material.dart';

// [Camera Painter]
// 카메라의 영역을 표시하는 부분입니다.
// Painter => 배경색
// Clip => 카메라 영역을 표시할 RRect

// * Painter 로 인해서 CameraPreview 를 두번 불러오는데
// 성능문제가 발견될 시 영역은 사용하지 않습니다.

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.grey.withOpacity(0.7), BlendMode.dstOut);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Clip extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(10, size.height / 2 - 200, size.width - 20, 390),
          const Radius.circular(20),
        ),
      );
    return path;
  }

  @override
  bool shouldReclip(oldClipper) {
    return true;
  }
}
