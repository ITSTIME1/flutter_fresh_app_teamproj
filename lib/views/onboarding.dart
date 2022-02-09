import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_bloc.dart';
import 'package:fresh_app_teamproj/bloc/bloc/login_page.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

// [OnboardingScreen]

// OnboardingScreen은 앱의 소개 화면 입니다.
// PageView를 활용해서 컨트롤 이전 if문을 사용했을때 리스트에 담겨있는
// 인덱스 값이 오버플로우가 되면 어플 자체가 멈췄기 때문에
// if문을 삭제하고 PageView 만을 사용했습니다.
// 각각의 페이지가 구분이 되어 있어 수정으로는 각각의 PageViewModel() 내에서만 수정해주면 됩니다.

class OnboardingScreen extends StatefulWidget {
  final UserRepository _userRepository;
  const OnboardingScreen({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  UserRepository get _userRepository => widget._userRepository;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // [BackGround Color Value]
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                  child: OnePageView(pageController: _pageController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SecondPageView(pageController: _pageController),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ThirdPageView(userRepository: _userRepository),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// [OnePage Class]

class OnePageView extends StatelessWidget {
  const OnePageView({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SkipButton

        SkipButton(pageController: _pageController),
        Center(
          child: Image(
            image: const AssetImage('lib/images/img1.png'),
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '심플한 디자인',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w300,
            fontFamily: 'NatoBold',
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '복잡한 디자인은 그만!\n잘 사용하지 않는 기능도 그만!\n오로지 보기 편하고 사용하는 것만!\n',
            style: TextStyle(
              color: Color.fromRGBO(89, 89, 89, 100),
              fontSize: 15.0,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// [SecondPage Class]

class SecondPageView extends StatelessWidget {
  const SecondPageView({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SkipButton(pageController: _pageController),
        Center(
          child: Image(
            image: const AssetImage('lib/images/img2.png'),
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ),
        const SizedBox(height: 10),
        const Text('카메라 기능',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'NatoBold',
            )),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            '오직 기본적인 카메라만 사용\n추가적인 기능 없이\n기본기능만 충분히 활용해보세요!',
            style: TextStyle(
              color: Color.fromRGBO(89, 89, 89, 100),
              fontSize: 15.0,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// [ThirdPage Class]

class ThirdPageView extends StatelessWidget {
  const ThirdPageView({
    Key? key,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 45),
        Center(
          child: Image(
            image: const AssetImage('lib/images/img3.png'),
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ),
        const SizedBox(height: 25),
        const Text('선택',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontFamily: 'NatoBold',
            )),
        const SizedBox(height: 30),
        const Text(
          '누구보다 먼저\n품질 좋은 야채와, 과일을 선별해보세요\n아래의 버튼을 클릭해보세요!',
          style:
              TextStyle(color: Color.fromRGBO(89, 89, 89, 100), fontSize: 15.0),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              width: MediaQuery.of(context).size.width / 1.5,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BlocProvider<LoginBloc>(
                          create: (context) =>
                              LoginBloc(userRepository: _userRepository),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

// [SkipButton Class]

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextButton(
            onPressed: () {
              _pageController.jumpToPage(2);
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
