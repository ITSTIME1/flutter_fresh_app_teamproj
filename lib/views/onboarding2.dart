import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/onboardingdata_page.dart';
import 'package:fresh_app_teamproj/views/login_page.dart';

import '../data/appstyle.dart';
import '../data/size_configs.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({Key? key}) : super(key: key);

  @override
  _OnboardingScreen2State createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  int currentPage = 0;
  // 한페이지에 여러 페이지를 움직이면서 동작하게 하는 컨트롤러
  PageController _pageController = PageController(initialPage: 0);

  // 점 인디케이터
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 9),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Color.fromRGBO(50, 180, 29, 100) // 현재 페이지면 인디케이터는 찐한색
            : Color.fromRGBO(167, 248, 154, 70),
        // 현재 페이지가 아니라면 연한색
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex 로 화면 비율을 버튼 화면과 나눔.
              flex: 9,
              child: PageView.builder(
                // 페이지를 넘기기 위해 페이지 컨트롤을 사용
                // onpagechanged 를 사용해서 현재 상테를 업데이트
                controller: _pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                itemBuilder: (context, index) => Column(
                  children: [
                    SizedBox(
                      height: sizeV * 20,
                    ),
                    Text(
                      onboardingContents[index].topTitle,
                      style: kTopTitle,
                      textAlign: TextAlign.center,
                    ),
                    // image
                    Container(
                      child: Image.asset(
                        onboardingContents[index].image,
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        // mediaquery size data value
                      ),
                    ),
                    SizedBox(
                      height: sizeV * 0.1,
                    ),

                    // '무슨앱이에요?
                    Text(
                      onboardingContents[index].title,
                      style: kTitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: sizeV * 1,
                    ),
                    // '신선함'
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        onboardingContents[index].subtitle,
                        style: kSubTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: sizeV * 1,
                    ),
                    // '설명'
                    Text(
                      onboardingContents[index].description,
                      style: kBodyText,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // 마지막 페이지라면 텍스트 버튼이 나오게
                  currentPage == onboardingContents.length - 1
                      ? SizedBox(
                          width: SizeConfig.blockSizeH! * 100,
                          height: SizeConfig.blockSizeH! * 15.1,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(50, 180, 29, 88),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                "시작해봐요",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.white,
                                ),
                              )),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            backBtn(
                              onPressed: () {
                                _pageController.previousPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                            ),
                            Row(
                              children: List.generate(
                                onboardingContents.length,
                                (index) => dotIndicator(index),
                              ),
                            ),
                            forwardBtn(
                              onPressed: () {
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 400),
                                    curve: Curves.easeInOut);
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 다음 버튼
class forwardBtn extends StatelessWidget {
  const forwardBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Icon(
        Icons.arrow_forward_ios,
        color: Color.fromRGBO(50, 180, 29, 100),
        size: 40.0,
      ),
    );
  }
}

// 이전 버튼
class backBtn extends StatelessWidget {
  const backBtn({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Icon(
        Icons.arrow_back_ios,
        color: Color.fromRGBO(50, 180, 29, 100),
        size: 40.0,
      ),
    );
  }
}
