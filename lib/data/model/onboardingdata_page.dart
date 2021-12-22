// Onboarding 페이지를 위한 data class

class OnBoarding {
  // 멤버변수 선언.
  final String topTitle; // Step1
  final String title; // 무슨앱이에요?
  final String subtitle; // fresh, Ai, 시작
  final String description; // 설명
  final String image; // image

  // 생성자.
  OnBoarding({
    required this.subtitle,
    required this.description,
    required this.topTitle,
    required this.title,
    required this.image,
  });
}

// List를 사용하는데 Onboarding value를 참조하여 List를 생성.
List<OnBoarding> onboardingContents = [
  // index 0
  OnBoarding(
    topTitle: "Step1",
    title: '무슨 앱이에요?',
    subtitle: "'신선함'",
    image: 'lib/images/img1.png',
    description:
        '오직 카메라, 갤러리만을 사용하여\nAI 데이터 수집을 통해서 실시간으로\n채소, 과일의 상태를 파악해주고\n고객 여러분들의 ‘빠른 선택’을 도와드립니다.',
  ),
  // index 1
  OnBoarding(
    topTitle: "Step2",
    image: 'lib/images/img2.png',
    title: '카메라와 갤러리만으로?',
    subtitle: "'AI'",
    description: '카메라 혹은 갤러리에서 찍은 이미지를\n보여주세요!\n그러면 자동으로 인공지능이 고객님께 알려드립니다.',
  ),
  // index 2
  OnBoarding(
    topTitle: "Step3",
    image: 'lib/images/img3.png',
    title: '시작해보세요!',
    subtitle: "'시작'",
    description: '장보러 가세요?\n오늘 식사도 신선한 재료를 사용하고 싶으신가요?\n저희가 도와 드립니다.',
  ),
];
