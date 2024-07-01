import 'package:call_match/presentation/home_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //delay fuction
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xffb42c44)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Stack(
                children: [
                  Positioned(
                    bottom: 25,
                    left: 75,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/git_splash.gif",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Call Match",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontFamily: "Anokha",
                    ),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
