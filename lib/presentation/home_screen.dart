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
                  child: Text(
                    "call match",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontFamily: "Anokha",
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 45),
                child: Column(
                  children: [
                    const Center(
                      child: Text("Lets gets closer"),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        child: const Text("Get started"),
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
