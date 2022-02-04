import 'package:camera/camera.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/data.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:fresh_app_teamproj/views/food.dart';
import 'package:fresh_app_teamproj/views/fruits.dart';
import 'package:fresh_app_teamproj/views/vegetable.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// Swiper_cards library를 활용해서 슬라이드 페이지를 적용했습니다.
// 메인페이지는 야채, 과일, 랜덤음식추천 기능을 구현하고 있습니다.
// 각각의 메인 페이지로 이동하여 TesnorFlow File을 연동합니다.
// 그렇게 되면 각각 학습시킨 데이터 모델만 갖고 있게 되므로
// 오차범위가 줄어들게 됩니다.
// 추가 기능으로 [장바구니 기능]의 도입을 차후에 생각하고 있습니다.
// [랜덤음식추천] 기능은 JSON을 이용해 음식리스트 중에서 한가지의 음식을 보여줍니다.
// [랜덤음식추천] 기능의 대해서는 추가적인 알고리즘이 필요합니다.
// 리팩토릭 필요

class TeachableMachine extends StatefulWidget {
  // : 세미콜런의 의미는 외부에서 값을 새로 받겠다는 의미이다.
  // user의 정보를 가지고 있는 즉 Firebase 의 정보는 userRepository 클래스 안에 있으므로
  // 클래스 내부에서 데이터를 처리하는게 아니라 외부에서 데이터를 받아올때 : 세미콜론을 사용해서
  // 값을 받아온다.
  const TeachableMachine({
    Key? key,
    required UserRepository userRepository,
  }) : super(key: key);

  @override
  _TeachableMachineState createState() => _TeachableMachineState();
}

class _TeachableMachineState extends State<TeachableMachine> {
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
      // Need to Change color
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SizedBox(
          height: 560,
          child: Swiper(
            layout: SwiperLayout.DEFAULT,
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
              color: Colors.grey[350],
              activeColor: Colors.white,
              activeSize: 10,
              space: 4,
            )),
            itemCount: items.length,
            itemWidth: MediaQuery.of(context).size.width / 1 * 64,
            itemHeight: MediaQuery.of(context).size.height / 1 * 64,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 460,
                      width: 340,
                      child: Card(
                        elevation: 9.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // [Image]

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await availableCameras().then(
                                      (value) {
                                        if (items[index].image ==
                                            'lib/images/vegetable.png') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Vegetable(
                                                camera: value,
                                              ),
                                            ),
                                          );
                                        } else if (items[index].image ==
                                            'lib/images/fruits.png') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Fruits(
                                                camera: value,
                                              ),
                                            ),
                                          );
                                        } else if (items[index].image ==
                                            'libe/images/food.png') {
                                          print('준비중');
                                        }
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    items[index].image,
                                    width: 250,
                                    height: 250,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // [Text]
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  items[index].title,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontFamily: 'Sairafont',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  items[index].subtitle,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
