import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'audio_incomming.dart'; // Import your AudioIncommingUI widget

class AudioOutgoingUI extends StatefulWidget {
  static const routeName = "outgoing-screen";
  final String contactname;
  final int uid;

  AudioOutgoingUI({super.key, required this.contactname, required this.uid});

  @override
  _AudioOutgoingUIState createState() => _AudioOutgoingUIState();
}

class _AudioOutgoingUIState extends State<AudioOutgoingUI> {
  late final RtcEngine _engine;
  final ValueNotifier<bool> callAcceptedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> localUserJoined = ValueNotifier<bool>(false);
  final ValueNotifier<int?> remoteUid = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          localUserJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          this.remoteUid.value = remoteUid;
          callAcceptedNotifier.value = true;

          // Navigate to the incoming call screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AudioIncommingUI(name: widget.contactname),
            ),
          );
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          this.remoteUid.value = null;
          callAcceptedNotifier.value = false;
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    final token = generateToken("test-channel",
        widget.uid.toString()); // Generate token for the local user

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannel(
      token: token,
      channelId: "test-channel",
      uid: widget.uid,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImageAndNameUI(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              name: widget.contactname,
              calltype: "Calling...",
              callAcceptedNotifier: callAcceptedNotifier,
            ),
            ValueListenableBuilder<bool>(
              valueListenable: callAcceptedNotifier,
              builder: (context, callAccepted, child) {
                return callAccepted
                    ? AfterAcceptCall(
                        callAccepted: callAcceptedNotifier,
                        onEnd: () async {
                          await _engine.leaveChannel();
                          await _engine.release();
                          Navigator.of(context).pop();
                        },
                      )
                    : AfterAcceptCall(onEnd: () {
                        Navigator.of(context).pop();
                      });
              },
            ),
          ],
        ),
      ),
    );
  }
}
