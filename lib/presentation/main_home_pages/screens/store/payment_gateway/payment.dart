import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class PaymentScreenUI extends StatelessWidget {
  const PaymentScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchAndMenu(),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileUI(),
            ],
          ),
          Container(
            height: 439,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(children: [],),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
