// import 'package:call_match/presentation/main_home_pages/screens/chat/chat_screen.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/profile_home.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/store_screen.dart';
import 'package:call_match/presentation/main_home_pages/widgets/bottam_nav_widget.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/contact_list_screen.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  static const routeName = "main_home-screen";
  MainHome({super.key});
  final _pages = [
    const ProfileHome(),
     StoreScreen(),
    ContactListScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.sizeOf(context).height;
    //final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 209, 202, 202),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: indexchangenotifier,
            builder: (context, int index, _) {
              return _pages[index];
            },
          ),
        ),
        bottomNavigationBar: const BottomNavWidget()
        // Stack(
        //   children: [
        //     Container(
        //       height: height - 735,
        //       width: width,
        //       color: const Color(0xffffdce0),
        //     ),
        //     ClipPath(
        //       clipper: CurvedBottomClipper(),
        //       child: const BottomNavWidget(),
        //     ),
        //   ],
        // )
        );
  }
}
