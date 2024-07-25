import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_home/widgets/add_coin_and_display.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_home/widgets/curve_ui_widget.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_home/widgets/listview_widget.dart';
import 'package:flutter/material.dart';

class ProfileHomeAgent extends StatelessWidget {
  const ProfileHomeAgent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CurveShapeUIAgent(width: width),
          //ADD COIN AND DISPLAY
          AddCoinDisplayUIAgent(),
          //USER LISTVIEW UIs with Tabs
          Expanded(
            child: DefaultTabController(
              length: 3, // Number of tabs
              child: ListViewUIAgent(
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
    );
  }
}
