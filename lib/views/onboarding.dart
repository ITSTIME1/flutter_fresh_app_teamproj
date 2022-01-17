import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

class OnboardingScreenTest extends StatefulWidget {
  final UserRepository _userRepository;
  const OnboardingScreenTest({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<OnboardingScreenTest> createState() => _OnboardingScreenTestState();
}

class _OnboardingScreenTestState extends State<OnboardingScreenTest> {
  UserRepository get _userRepository => widget._userRepository;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // [BackGround Color Value]
          Container(
            color: Colors.white,
          ),
          Container(
            child: PageView(
              physics: const ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SkipButton(context),
                      Center(
                        child: Image(
                          image: const AssetImage('lib/images/img1.png'),
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '우리는',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '복잡한 인터페이스는 이젠 그만..\n오직 "카메라" 기능만을 사용하여 \n AI 데이터 수집과 함께 "실시간"으로\n 채소, 과일의 상태를 파악해주고\n 여러분들께 "빠른 선택"을 도와드립니다.',
                        style: TextStyle(
                          color: Color.fromRGBO(89, 89, 89, 100),
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SkipButton(context),
                      Center(
                        child: Image(
                          image: const AssetImage('lib/images/img2.png'),
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('단순해도',
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                      const SizedBox(height: 20),
                      const Text(
                        '"카메라"\n 혹은 갤러리에서 찍은 이미지를 \n보여주세요\n그러면 자동적으로 인공지능 알고리즘을 통해 \n 화면상에 수치로 보여드립니다.',
                        style: TextStyle(
                            color: Color.fromRGBO(89, 89, 89, 100),
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
                      Center(
                        child: Image(
                          image: const AssetImage('lib/images/img3.png'),
                          width: MediaQuery.of(context).size.width / 1,
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('정확해',
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                      const SizedBox(height: 20),
                      const Text(
                        '"똑똑하게"\n 선택해보세요\n 신선한 재료는 항상 \n 가까이에 있습니다.\n ',
                        style: TextStyle(
                            color: Color.fromRGBO(89, 89, 89, 100),
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return BlocProvider<LoginBloc>(
                                        create: (context) => LoginBloc(
                                            userRepository: _userRepository),
                                        child: LoginPage(
                                          userRepository: _userRepository,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: const Text(
                                '시작해보세요',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container SkipButton(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        // when clicking the button, go to the [Login Page]
        onPressed: () {
          _pageController.jumpToPage(2);
        },
        child: const Text('Skip',
            style: TextStyle(color: Colors.green, fontSize: 20.0)),
      ),
    );
  }
}
