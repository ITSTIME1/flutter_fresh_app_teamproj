import 'package:flutter/material.dart';

// [TeachableMachine Testing Code]

// 1. 본 모델에서는 아래와 같은 사실들을 입증하는 작업을 진행합니다.

// (1) 객체를 정확하게 인식하는가?
// (2) 객체의 데이터가 많아도 학습을 시킬 수 있는가?
// (3) 학습시킨 데이터를 바탕으로 채소라면 상했는지 상하지 않았는지를 판별해 => 추천과 비추천을 정확하게 나눌 수 있는가?
// (4) loadModel()파일로 학습시킨 TensorFlow 데이터 이외에 데이터를 감지하면 null 값의 이미지를 리턴하는가?
// (5) 스크린샷을 통해 퍼센티지로 나오는 데이터를 캐치할 수 있는가?
// (6) 리스트 기능을 활용하여 스크린샷을 담을 수 있는가?
// (7) 각 라벨마다 '정보'와 '이미지'가 보여지는지 => Dialog 형식적용
// => '사과'를 분석하고 있다면, 그 사과가 어떤 기준을 갖고 데이터를 도출해 냈는지의 대한 이미지와 정보를 보여줍니다.
// => 'JSON방식의 정보' 와 + '어떤 데이터 파일을 썼는지' 를 보여줍니다.

// 2. 본 모델은 두 가지 기술을 방향성을 가지고 테스트 합니다.

// (1) python CNN 방식으로 학습시킨 데이터를 가지고 tfile set을 만들어 사용합니다.
// (2) TeachableMachine 구글에서 데이터 신경망 학습 시스템을 활용하여 tfile set을 만들어 활용합니다.

// 3. 테스트 결과 성능의 차이가 우위에 있는 기술로 적용합니다.

class Teach extends StatefulWidget {
  const Teach({Key? key}) : super(key: key);

  @override
  _TeachState createState() => _TeachState();
}

class _TeachState extends State<Teach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Testing'),
      ),
    );
  }
}
