import 'package:flutter/material.dart';

ValueNotifier<int> indexchangenotifier = ValueNotifier(0);

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexchangenotifier,
      builder: (
        context,
        newindex,
        _,
      ) {
        return BottomNavigationBar(
          currentIndex: newindex,
          onTap: (index) {
            indexchangenotifier.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.red,
          selectedIconTheme: const IconThemeData(color: Colors.red),
          unselectedIconTheme: const IconThemeData(color: Colors.red),
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/chat.png",
                      ),
                    ),
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Container(
                   height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/chat.png",
                      ),
                    ),
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Container(
                   height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/chat.png",
                      ),
                    ),
                  ),
                ),
                label: ""),
          ],
        );
      },
    );
  }
}
