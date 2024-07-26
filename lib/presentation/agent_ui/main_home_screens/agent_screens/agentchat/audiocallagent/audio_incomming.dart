import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/attent_and_end_call.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';

class AudioIncommingUIAgent extends StatelessWidget {
  final String name;
  final String userId;
  //final String channelId;
  final ValueNotifier<bool> callAccepted = ValueNotifier<bool>(false);

  AudioIncommingUIAgent({
    super.key,
    required this.name,
    required this.userId,
    // required this.channelId,
  });
  final RtcEngine engine = createAgoraRtcEngine();
  Future<void> _initAgora() async {
    await [Permission.microphone].request();

    await engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
        },
      ),
    );

    final token = generateToken("test-channel", userId);

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.joinChannelWithUserAccount(
      token: token,
      channelId: "test-channel",
      userAccount: userId,
      options: const ChannelMediaOptions(),
    );
  }

  void _acceptCall(BuildContext context) async {
    callAccepted.value = true;
    await _initAgora();
  }

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
              name: name,
              calltype: "Incoming call...",
              callAcceptedNotifier: callAccepted,
              callType: '',
            ),
            ValueListenableBuilder<bool>(
              valueListenable: callAccepted,
              builder: (context, accepted, child) {
                return accepted
                    ? AfterAcceptCall(
                        onEnd: () async {
                          await engine.release();
                          await engine.leaveChannel();
                          Navigator.of(context).pop();
                        },
                      )
                    : AttentAndEndCall(
                        height: height,
                        width: width,
                        onAccept: () {
                          _acceptCall(context);
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
      ),
    );
  }
}
