// import 'package:call_match/presentation/main_home_pages/screens/chat/chat_screen.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_home/profile_home.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_store/store_screen.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/contact_list_screen.dart';
import 'package:call_match/presentation/agent_ui/widgets/bottam_nav_widget.dart';
import 'package:flutter/material.dart';

class MainHomeAgent extends StatelessWidget {
  static const routeName = "screen-agent";
  MainHomeAgent({super.key});
  final _pagesagent = [
    const ProfileHomeAgent(),
    const StoreScreenAgent(),
    const ContactListScreenAgent(),
  ];
  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.sizeOf(context).height;
    //final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 209, 202, 202),
        body: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: indexchangenotifieragent,
            builder: (context, int index, _) {
              return _pagesagent[index];
            },
          ),
        ),
        bottomNavigationBar: const BottomNavWidgetAgent()
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
