import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/widgets/attent_and_end_call.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/widgets/imageandname.dart';
import 'package:flutter/material.dart';

class AudioIncommingUIAgent extends StatelessWidget {
  AudioIncommingUIAgent({super.key, required this.name});

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
          ImageAndNameUIAgent(
            height: height,
            width: width,
            name: name,
            calltype: "Incomming call...",
            callAcceptedNotifieragent: callAccepted,
            callType: '',
          ),
          ValueListenableBuilder<bool>(
            valueListenable: callAccepted,
            builder: (context, accepted, child) {
              return accepted
                  ? AfterAcceptCallAgent(
                      onEnd: () {
                        Navigator.of(context).pop();
                      },
                    )
                  : AttentAndEndCallAgent(
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
