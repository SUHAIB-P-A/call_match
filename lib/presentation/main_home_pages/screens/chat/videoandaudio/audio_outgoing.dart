import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AudioOutgoingUI extends StatelessWidget {
  static const routeName = "outgoing-screen";
  AudioOutgoingUI({
    super.key,
    required this.contactname,
  });
  final String contactname;
  final ValueNotifier<bool> callAcceptedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageAndNameUI(
              height: height,
              width: width,
              name: contactname,
              calltype: "Calling...",
              callAcceptedNotifier: callAcceptedNotifier,
            ),
            AfterAcceptCall(
              callAccepted: callAcceptedNotifier,
              onEnd: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
