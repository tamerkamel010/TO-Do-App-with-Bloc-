import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/To_Do/to_do.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: MediaQuery.sizeOf(context).width / 2.5,
        splash: CircleAvatar(
          backgroundColor: Colors.white,
          radius: (MediaQuery.sizeOf(context).width/2)+20,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Image.asset(
                      "lib/assets/images/marker.png",
                    ),
          ),
        ),
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.deepPurple,
        nextScreen: const ToDo());
  }
}
