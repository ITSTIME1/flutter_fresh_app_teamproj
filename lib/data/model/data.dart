//** Swiper 모델의 필요한 컨포넌트를 클래스로 묶어 사용했습니다.
// List로 Item을 참조하여 title, subtitle(description), image, position의 위치를 사용했습니다.
// 후에 추가적으로 추가되어야 하는 컨포넌나 위젯이 있다면 이 파일에 추가해주면 됩니다.*/
class Item {
  late final dynamic image;
  final String title;
  final String subtitle;

  Item({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

// List item
List<Item> items = [
  Item(
      title: 'Vegetable',
      subtitle: '오늘도 신선한 야채가 필요하세요?\n양배추, 피망, 상추 등\n이미지를 클릭해보세요!',
      image: 'lib/images/vegetable.png'),
  Item(
      title: 'Fruits',
      subtitle: '오늘도 신선한 과일이 필요하세요?\n사과, 딸기, 복숭아 등\n이미지를 클릭해보세요!',
      image: 'lib/images/fruits.png'),
  Item(
      title: 'Food',
      subtitle: '오늘은 무슨 요리를 할까요?\n랜덤으로 요리를 추천받아보세요!\n이미지를 클릭해보세요!',
      image: 'lib/images/food.png')
];
