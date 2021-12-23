import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final User? firebaseUser;
  const HomeScreen({Key? key, this.firebaseUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text('HomeScreen is ${firebaseUser}'),
          ),
        ],
      ),
    );
  }
}
