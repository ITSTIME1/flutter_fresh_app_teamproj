import 'package:flutter/material.dart';

// [SplashScreen]

// SplashScreen 페이지는 앱이 처음 시작되었을때 나타나는 페이지입니다.
// 결정사항 ['폰트', '로고', '색상']

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
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
              color: Color.fromRGBO(
                  194, 255, 147, 70), // main color hex -> rgba value
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fresh',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 6,
                  fontFamily: 'Sairafont', // free font 'Impact'
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 6,
            child: CircularProgressIndicator(
              valueColor: animationController.drive(
                ColorTween(begin: Colors.greenAccent, end: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
