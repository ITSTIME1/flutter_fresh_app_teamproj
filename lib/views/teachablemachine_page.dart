import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// Swiper_cards library를 활용해서 슬라이드 페이지를 적용했습니다.

class TeachableMachine extends StatefulWidget {
  final UserRepository _userRepository;
  const TeachableMachine({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  _TeachableMachineState createState() => _TeachableMachineState();
}

class _TeachableMachineState extends State<TeachableMachine> {
  // Image의 List 값을 dynamic 값으로 받아 저장했습니다.
  // String
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
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 25),
              const Text('옆으로 드래그 하여 클릭!',
                  style: TextStyle(color: Colors.grey, fontSize: 13)),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
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
                            color: Colors.grey[400]!.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          imgList[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
