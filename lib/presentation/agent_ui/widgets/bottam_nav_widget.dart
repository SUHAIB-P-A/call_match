import 'package:flutter/material.dart';

ValueNotifier<int> indexchangenotifieragent = ValueNotifier(0);

class BottomNavWidgetAgent extends StatelessWidget {
  const BottomNavWidgetAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexchangenotifieragent,
      builder: (
        context,
        newindex,
        _,
      ) {
        return BottomNavigationBar(
          currentIndex: newindex,
          onTap: (index) {
            indexchangenotifieragent.value = index;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.red,
          selectedIconTheme: const IconThemeData(color: Colors.red),
          unselectedIconTheme: const IconThemeData(color: Colors.red),
          items: [
            BottomNavigationBarItem(
                tooltip: "Home",
                icon: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/home.png",
                      ),
                    ),
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                tooltip: "Store",
                icon: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/shopping-bag.png",
                      ),
                    ),
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                tooltip: "Chats",
                icon: Container(
                  height: 35,
                  width: 35,
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
