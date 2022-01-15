class Item {
  final int position;
  final dynamic image;
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
