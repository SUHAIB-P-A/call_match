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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/profile.png"),
                  ),
                ),
              ),
              const SearchAndMenu()
            ],
          ),
        ),
      ],
    );
  }
}
