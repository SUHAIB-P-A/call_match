import 'package:call_match/presentation/main_home_pages/screens/home/widgets/add_coin_and_display.dart';
import 'package:flutter/material.dart';

class ProfileUI extends StatelessWidget {
  const ProfileUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        const AddCoinDisplayUI()
      ],
    );
  }
}
