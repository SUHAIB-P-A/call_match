import 'package:flutter/material.dart';
import 'package:call_match/presentation/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/homeimage.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox.expand(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        left: 69,
                        top: -1,
                        child: Text(
                          "💕",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        "Call Match",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: "Anokha",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "Lets gets closer! 💕",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffb42c44),
                          minimumSize: const Size(
                            300,
                            40,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                        child: const Text(
                          "GET STARTED",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
