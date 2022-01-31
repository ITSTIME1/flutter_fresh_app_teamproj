import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// [SplashScreen]

// SplashScreen 페이지는 앱이 처음 시작되었을때 나타나는 페이지입니다.
// 결정사항 ['폰트', '로고', '색상']

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 기존 background color 167, 248, 154, 0.82
  // new background color 194, 255, 147, 70
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(194, 255, 147, 70),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: (Colors.grey[100])!,
                child: Text(
                  'Fresh',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 6,
                    fontFamily: 'Sairafont', // free font 'Impact'
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
