// ignore_for_file: implementation_imports

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/src/foundation/key.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarded.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
        splash: Center(
          child: Column(
            children: [
              SizedBox(
                // color: Colors.white,
                height: mHeight * 0.4,
                width: mWidth * 0.4,
                child: FittedBox(
                  child: Image.asset(
                    'images/Group 1735.png',
                  ),
                  //fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(),
              Text("Run On",
                  style: GoogleFonts.pacifico(
                      fontSize: mHeight * 0.06,
                      color: Color.fromARGB(255, 217, 218, 209),
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        splashIconSize: mHeight * 0.6,
        backgroundColor: Colors.black,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: OnBoardScreen());
  }
}
