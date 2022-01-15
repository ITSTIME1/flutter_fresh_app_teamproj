import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:fresh_app_teamproj/data/model/data.dart';
import 'package:fresh_app_teamproj/repository/user_repository.dart';
import 'package:simple_shadow/simple_shadow.dart';

//** TeachableMachine 위젯은 메인기능 페이지입니다.
// Swiper_cards library를 활용해서 슬라이드 페이지를 적용했습니다.
// 메인페이지는 야채, 과일, 랜덤음식추천 기능을 구현하고 있습니다.
// 각각의 메인 페이지로 이동하여 TesnorFlow File을 연동합니다.
// 그렇게 되면 각각 학습시킨 데이터 모델만 갖고 있게 되므로
// 오차범위가 줄어들게 됩니다.
// 추가 기능으로 [장바구니 기능]의 도입을 차후에 생각하고 있습니다.
// [랜덤음식추천] 기능은 JSON을 이용해 음식리스트 중에서 한가지의 음식을 보여줍니다.
// [랜덤음식추천] 기능의 대해서는 추가적인 알고리즘이 필요합니다.

class TeachableMachine extends StatefulWidget {
  final UserRepository _userRepository;
  const TeachableMachine({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

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
        // ** All Swiper Size position change widget
        child: SizedBox(
          height: 600,
          child: Swiper(
            //** Control 추가 여부는 상의해서. */

            // control: const SwiperControl(
            //   size: 30,
            //   color: Colors.white,
            // ),

            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
              color: Colors.grey[350],
              activeColor: Colors.white,
              activeSize: 12,
              space: 4,
            )),
            layout: SwiperLayout.TINDER,
            itemCount: items.length,
            itemWidth: MediaQuery.of(context).size.width / 1 * 64,
            itemHeight: MediaQuery.of(context).size.height / 1 * 100,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // ** Swiper position default => left
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 460,
                          width: 340,
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            color: Colors.white,
                            //** Title */
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 260),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Text(
                                        items[index].title,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 40,
                                          fontFamily: 'Sairafont',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20.0,
                                  ),
                                  child: Text(
                                    items[index].subtitle,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(75, 75, 75, 100),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //** Image  */

                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 100,
                      ),
                      SimpleShadow(
                        child: Image.asset(items[index].image),
                        opacity: 0.6,
                        color: Colors.black,
                        offset: const Offset(10, 10),
                        sigma: 4,
                      ),
                    ],
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
