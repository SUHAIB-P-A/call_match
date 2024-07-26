import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:permission_handler/permission_handler.dart';

class AudioOutgoingUI extends StatefulWidget {
  static const routeName = "outgoing-screen";
  final String contactname;
  final String callerUid;
  final String receiverUid;

  AudioOutgoingUI(
      {super.key,
      required this.contactname,
      required this.callerUid,
      required this.receiverUid,
      required String contactName});

  @override
  _AudioOutgoingUIState createState() => _AudioOutgoingUIState();
}

class _AudioOutgoingUIState extends State<AudioOutgoingUI> {
  late final RtcEngine _engine;
  final ValueNotifier<bool> callAcceptedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> localUserJoined = ValueNotifier<bool>(false);
  final ValueNotifier<int?> remoteUid = ValueNotifier<int?>(null);
  late RTMService rtmService;

  @override
  void initState() {
    super.initState();
    initAgora();
    startCall(widget.receiverUid); // Start the call and send the RTM message
  }

  Future<void> initAgora() async {
    await [Permission.microphone].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
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

  Future<void> startCall(String receiverId) async {
    rtmService = RTMService();
    await rtmService.initialize(widget.callerUid);

    String callInvitation = "Incoming call from ${widget.contactname}";
    await rtmService.sendMessage(receiverId, callInvitation);
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
              callType: '',
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
                    : AfterAcceptCall(onEnd: () async {
                        await _engine.leaveChannel();
                        await _engine.release();
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

class RTMService {
  late AgoraRtmClient _rtmClient;

  Function(String message, String peerId)? onMessageReceived;

  Future<void> initialize(String userId) async {
    _rtmClient = await AgoraRtmClient.createInstance(appId);
    _rtmClient.onMessageReceived = (RtmMessage message, String peerId) {
      print("Private message from $peerId: ${message.text}");
      if (onMessageReceived != null) {
        onMessageReceived!(message.text, peerId);
      }
    };

    await _rtmClient.login(null, userId);
  }

  Future<void> sendMessage(String peerId, String message) async {
    RtmMessage rtmMessage = RtmMessage.fromText(message);
    await _rtmClient.sendMessageToPeer2(
      peerId,
      rtmMessage,
    );
  }

  void setOnMessageReceived(Function(String message, String peerId) callback) {
    onMessageReceived = callback;
  }
}
