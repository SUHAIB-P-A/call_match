import 'dart:async'; // Import Timer

import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/attent_and_end_call.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';

class AudioIncommingUI extends StatelessWidget {
  final String name;
  final String userId;
  final String channelId;
  final ValueNotifier<bool> callAccepted = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoudspeakerOn = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isMuted = ValueNotifier<bool>(false);
  Timer? _timeoutTimer; // Timer to handle call acceptance timeout
  int counter = 0;

  AudioIncommingUI({
    super.key,
    required this.name,
    required this.userId,
    required this.channelId,
  });

  final RtcEngine engine = createAgoraRtcEngine();
  final AudioPlayer player1 = AudioPlayer();

  Future<void> _initAgora(BuildContext context) async {
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
          counter++;
          Future.delayed(const Duration(seconds: 3), () async {
          _checkCounter(context);
          });
        },
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) async {
          debugPrint("Remote user $remoteUid joined");
          counter++;
          //_checkCounter(context);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) async {
          debugPrint("Remote user $remoteUid left channel");
          counter--;
          await engine.leaveChannel();
          await engine.release();
          await player1.stop();
          Navigator.of(context).pop();
        },
      ),
    );

    final token = generateToken(channelId, userId);

    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.joinChannelWithUserAccount(
      token: token,
      channelId: channelId,
      userAccount: userId,
      options: const ChannelMediaOptions(),
    );

    // Start the timeout timer
  }
void _checkCounter(BuildContext context) async {
    if (counter == 1) {
      await engine.leaveChannel();
      await engine.release();
      await player1.stop();
      Navigator.of(context).pop();
    }
  }
  void _startTimeoutTimer(BuildContext context) {
    _timeoutTimer = Timer(Duration(seconds: 15), () {
      if (!callAccepted.value) {
        player1.stop();
        // If call is not accepted within 15 seconds, pop the page
        Navigator.of(context).pop();
      }
    });
  }

  void _cancelTimeoutTimer() {
    _timeoutTimer?.cancel();
  }

  void _acceptCall(BuildContext context) async {
    log(channelId.toString());
    callAccepted.value = true;
    _cancelTimeoutTimer(); // Cancel the timer when call is accepted
    await player1.stop();
    await _initAgora(context);
  }

  void _toggleLoudspeaker() {
    isLoudspeakerOn.value = !isLoudspeakerOn.value;
    engine.setEnableSpeakerphone(isLoudspeakerOn.value);
  }

  void _toggleMute() {
    isMuted.value = !isMuted.value;
    engine.muteLocalAudioStream(isMuted.value);
  }

  @override
  Widget build(BuildContext context) {
    _startTimeoutTimer(context);
    log(channelId.toString());
    player1.setReleaseMode(ReleaseMode.loop);
    player1.play(AssetSource("audio/incomming.mp3"));
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
                        onToggleLoudspeaker: _toggleLoudspeaker,
                        onToggleMute: _toggleMute,
                        isLoudspeakerOn: isLoudspeakerOn,
                        isMuted: isMuted,
                      )
                    : AttentAndEndCall(
                        height: height,
                        width: width,
                        onAccept: () {
                          _acceptCall(context);
                        },
                        onEndCall: () async {
                          await player1.stop();
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
