import 'package:call_match/presentation/main_home_pages/screens/home/widgets/profile_screen.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/userdetails.dart';
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
          left: 330,
          top: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFD93755),
                  ),
                  child: const Icon(
                    Icons.account_circle,
                    size: 55,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10), // Adjust spacing if necessary
            ],
          ),
        ),
      ],
    );
  }
}
