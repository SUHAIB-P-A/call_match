import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  const Cards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 230,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 82, 78, 78),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/AI_Image9.png"),
              ),
            ),
          ),
          Column(
            children: [
              const Text(
                "Cards",
              ),
              Container(
                height: 25,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/AI_Image (2).png"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
