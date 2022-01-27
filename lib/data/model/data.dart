//** Swiper 모델의 필요한 컨포넌트를 클래스로 묶어 사용했습니다.
// List로 Item을 참조하여 title, subtitle(description), image, position의 위치를 사용했습니다.
// 후에 추가적으로 추가되어야 하는 컨포넌나 위젯이 있다면 이 파일에 추가해주면 됩니다.*/
class Item {
  final int position;
  late final dynamic image;
  final String title;
  final String subtitle;

  Item(
    this.position, {
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

// List item
List<Item> items = [
  Item(1,
      title: 'Vegetable',
      subtitle: '각종 신선한 야채의 선별을 도와 드립니다.\n양배추, 시금치, 상추, 피망 등\n오늘의 신선한 야채는..?',
      image: 'lib/images/vegetable.png'),
  Item(2,
      title: 'Fruits',
      subtitle: '과일의 신선도를 도와 드립니다!\n사과, 딸기, 복숭아, 참외 등\n오늘의 신선한 과일은..?',
      image: 'lib/images/fruits.png'),
  Item(3,
      title: 'Food',
      subtitle: '무슨 요리를 할지 생각이 안나나요?\n그럴땐 랜덤으로 추천받아보세요!',
      image: 'lib/images/food.png')
];
