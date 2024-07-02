import 'package:call_match/presentation/main_home_pages/screens/home/widgets/add_coin_and_display.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/listview_widget.dart';
import 'package:flutter/material.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //ADD COIN AND DISPLAY
          AddCoinDisplayUI(),
          SizedBox(
            height: 15,
          ),
          //USER LISTVIEW UIs
          ListViewUI(),
        ],
      ),
    );
  }
}
