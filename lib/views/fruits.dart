import 'package:flutter/material.dart';

class Fruits extends StatelessWidget {
  const Fruits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('과일'),
        ],
      ),
    );
  }
}
