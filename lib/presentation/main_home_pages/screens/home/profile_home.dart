import 'package:call_match/presentation/main_home_pages/screens/home/widgets/add_coin_and_display.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/listview_widget.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
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
                left: 50,
                top: 10,
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
          ),
          //ADD COIN AND DISPLAY
          const AddCoinDisplayUI(),
          //  const SizedBox(
          //    height: 05,
          //  ),
          //USER LISTVIEW UIs
          const ListViewUI(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
