import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/attent_and_end_call.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AudioIncommingUI extends StatelessWidget {
  AudioIncommingUI({super.key, required this.name});

  final String name;
  final ValueNotifier<bool> callAccepted = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageAndNameUI(
            height: height,
            width: width,
            name: name,
            calltype: "Incomming call...",
            callAcceptedNotifier: callAccepted, callType: '',
          ),
          ValueListenableBuilder<bool>(
            valueListenable: callAccepted,
            builder: (context, accepted, child) {
              return accepted
                  ? AfterAcceptCall(
                      onEnd: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : AttentAndEndCall(
                      height: height,
                      width: width,
                      onAccept: () {
                        callAccepted.value = true;
                      },
                      onEndCall: () {
                        callAccepted.value = false;
                        Navigator.of(context).pop();
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}