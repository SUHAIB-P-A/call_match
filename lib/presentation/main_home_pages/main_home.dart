import 'package:call_match/presentation/main_home_pages/screens/chat/chat_screen.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/profile_home.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/store_screen.dart';
import 'package:call_match/presentation/main_home_pages/widgets/bottam_nav_widget.dart';
import 'package:flutter/material.dart';

class MainHome extends StatelessWidget {
  static const routeName = "main_home-screen";
  MainHome({super.key});
  final _pages = [
    const ProfileHome(),
    const StoreScreen(),
    const ChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: const BottomNavWidget(),
    );
  }
}
