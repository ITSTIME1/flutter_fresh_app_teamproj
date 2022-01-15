import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/data/model/data.dart';

class Vegetable extends StatelessWidget {
  final Item items;
  Vegetable({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('야채'),
        ],
      ),
    );
  }
}
