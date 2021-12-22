import 'package:flutter/material.dart';

// mediaquery data class

class SizeConfig {
  // double 로 설정한 이유는 소수점 까지 담기위함.
  // static 메소드를 통해 손쉽게 호출 할 수 있습니다.
  // 공통적으로 또는 널리 사용되는 유틸리티 및 기능에 대해서는 정적 방법 대신 최상위(top-level) 기능을 사용하는 것이 좋습니다.

  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeH;
  static double? blockSizeV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.width;
    // MediaQuerySize value / 100
    blockSizeH = screenWidth! / 100;
    blockSizeV = screenHeight! / 100;
  }
}
