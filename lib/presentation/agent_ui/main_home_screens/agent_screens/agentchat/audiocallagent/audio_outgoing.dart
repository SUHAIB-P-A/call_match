import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_incomming.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'audio_incomming.dart';

class AudioOutgoingUIAgent extends StatefulWidget {
  static const routeName = "outgoing-screen";
  final String contactname;
  final String callerUid;
  final String receiverUid;

  const AudioOutgoingUIAgent(
      {super.key,
      required this.contactname,
      required this.callerUid,
      required this.receiverUid,
      required String contactName});

  @override
  _AudioOutgoingUIAgentState createState() => _AudioOutgoingUIAgentState();
}

class _AudioOutgoingUIAgentState extends State<AudioOutgoingUIAgent> {
  late final RtcEngine _engine;
  final ValueNotifier<bool> callAcceptedNotifieragent = ValueNotifier<bool>(false);
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
          callAcceptedNotifieragent.value = true;

          // Navigate to the incoming call screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AudioIncommingUIAgent(name: widget.contactname),
            ),
          );
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          this.remoteUid.value = null;
          callAcceptedNotifieragent.value = false;
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    final token = generateToken("test-channel", widget.callerUid);

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannelWithUserAccount(
      token: token,
      channelId:
          "test-channel", // Ensure the channel name is unique for each call
      userAccount: widget.callerUid,
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
              callAcceptedNotifier: callAcceptedNotifieragent,
              callType: '',
            ),
            ValueListenableBuilder<bool>(
              valueListenable: callAcceptedNotifieragent,
              builder: (context, callAccepted, child) {
                return callAccepted
                    ? AfterAcceptCall(
                        callAccepted: callAcceptedNotifieragent,
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
