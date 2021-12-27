// * Splash Screen 페이지

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fresh_app_teamproj/views/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(
                  167, 248, 154, 0.82), // main color hex -> rgba value
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Fresh',
                style: TextStyle(
                  fontSize: 100,
                  fontFamily: 'impact', // free font 'Impact'
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(10, 10),
                      blurRadius: 4,
                    ),
                  ],
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
