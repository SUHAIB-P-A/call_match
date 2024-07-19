import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:flutter/material.dart';

class CurveShapeUI extends StatelessWidget {
  const CurveShapeUI({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 118,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/image.png"),
            ),
          ),
        ),
        Positioned(
          left: 250,
          top: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD93755),
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10), // Adjust spacing if necessary
              const SearchAndMenu(),
            ],
          ),
        ),
      ],
    );
  }
}
