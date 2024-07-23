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
            shape: BoxShape.circle,
            color: Color(0xFFD93755),
          ),
          child: const Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        const AddCoinDisplayUI()
      ],
    );
  }
}
