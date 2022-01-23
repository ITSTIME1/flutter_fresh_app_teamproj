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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(
                  167, 248, 154, 0.82), // main color hex -> rgba value
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fresh',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width,
                  fontFamily: 'impact', // free font 'Impact'
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(10, 10),
                      blurRadius: 4,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30.0,
                height: 30.0,
                child: CircularProgressIndicator(
                  valueColor: animationController.drive(
                    ColorTween(begin: Colors.greenAccent, end: Colors.white),
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
