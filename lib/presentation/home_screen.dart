import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homeimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
         child: SizedBox.expand(),
      ),
    );
  }
}
