import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// 메인 페이지 기능은 아직 구현이 되지 않았습니다.
// 구현이 되면 이 페이지에 추가될 예정입니다.
class TeachableMachine extends StatefulWidget {
  final UserRepository _userRepository;
  const TeachableMachine({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _TeachableMachineState createState() => _TeachableMachineState();
}

class _TeachableMachineState extends State<TeachableMachine> {
  final List<dynamic> imgList = [
    'lib/images/vegetable.png',
    'lib/images/fruits.png',
    'lib/images/food.png',
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              const Text(
                'Fresh',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              const Text(
                '무엇을 원하시나요?',
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              SizedBox(height: 4),
              const Text('드래그 하여 클릭!',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Swiper(
                    controller: SwiperController(),
                    pagination: const SwiperPagination(
                      margin: EdgeInsets.all(20.0),
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.green),
                    ),
                    curve: Curves.easeIn,
                    itemCount: imgList.length,
                    itemWidth: MediaQuery.of(context).size.width / 1,
                    itemHeight: MediaQuery.of(context).size.width / 1,
                    layout: SwiperLayout.TINDER,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            imgList[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
