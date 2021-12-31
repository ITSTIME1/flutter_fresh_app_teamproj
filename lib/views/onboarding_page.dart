import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/appstyle.dart';
import 'package:fresh_app_teamproj/data/model/onboardingdata_page.dart';
import 'package:fresh_app_teamproj/data/model/sizeconfigs_page.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';

// ** 앱을 처음 런치하면 보여질 소개 화면 입니다.
// 폰트, 사이즈, 색상 등은 추가적으로 수정되어야 하는 부분입니다.
// OnboardingScreen 또한 Bloc Pattern으로 제작되어야 합니다.

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //* For PageView variable

  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  //* Circle indicator

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
    //* SizeConfig value

    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: PageView.builder(
                controller: _pageController,
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
                  //* Last Page Logic
                  //* 해석: onboardingPages 총 3개니까 index로 치면 3-1 2번째 페이지가 마지막페이지.

                  if (currentPage == onboardingContents.length - 1)
                    SizedBox(
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
                        ),
                      ),
                    )

                  //* First Page Logic

                  else if (currentPage == onboardingContents.length - 3)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(15),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            },
                            child: Text(
                              '다음',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )

                  //* Second Page Logic

                  else if (currentPage == onboardingContents.length - 2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: RaisedButton(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.all(15),
                            onPressed: () {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOut);
                            },
                            child: Text(
                              '다음',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//* 다음 버튼
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

//* 이전 버튼
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
