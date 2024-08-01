import 'package:call_match/presentation/main_home_pages/screens/home/widgets/add_coin_and_display.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/curve_ui_widget.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/listview_widget.dart';
import 'package:flutter/material.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: Colors.transparent,
        //const Color(0xffffdce0),
        body: Stack(
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "assets/images/pexels-karolina-grabowska-4197491.jpg"),
                ),
              ),
              child: SizedBox.expand(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurveShapeUI(width: width),
                //ADD COIN AND DISPLAY
                AddCoinDisplayUI(),
                //USER LISTVIEW UIs with Tabs
                Expanded(
                  child: DefaultTabController(
                    length: 3, // Number of tabs
                    child: ListViewUI(
                      height: height,
                      width: width,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ));
  }
}
