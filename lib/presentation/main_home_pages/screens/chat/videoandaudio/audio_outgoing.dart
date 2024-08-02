import 'dart:developer';

import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/rating_agent/rating_agent.dart';
import 'package:call_match/data/start_call/start_call.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/listview_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/functions/tokengeneration.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/after_call_accept_ui.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/widgets/imageandname.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioOutgoingUI extends StatefulWidget {
  static const routeName = "outgoing-screen";
  final String contactname;
  final String callerUid;
  final String receiverUid;

  AudioOutgoingUI({
    super.key,
    required this.contactname,
    required this.callerUid,
    required this.receiverUid,
  });

  @override
  _AudioOutgoingUIState createState() => _AudioOutgoingUIState();
}

class _AudioOutgoingUIState extends State<AudioOutgoingUI> {
  late final RtcEngine _engine;
  final ValueNotifier<bool> callAcceptedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> localUserJoined = ValueNotifier<bool>(false);
  final ValueNotifier<int?> remoteUid = ValueNotifier<int?>(null);
  late RTMService rtmService;
  late String ids;

  final String channelIdforcall = const Uuid().v4(); // Unique channel ID

  @override
  void initState() {
    super.initState();
    initAgora();
    startCall(widget.receiverUid);
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
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) async {
          debugPrint("Remote user $remoteUid joined");
          this.remoteUid.value = remoteUid;
          await player1.stop();
          final model = StartCall.create(
            callerId: widget.callerUid,
            agentId: widget.receiverUid,
            agoraChannelName: channelIdforcall,
          );
          final String id = await ApiCallFunctions.instance.startcall(model);
          ids = id;
          log(id);
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

    final token = generateToken(channelIdforcall, widget.callerUid);

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.joinChannelWithUserAccount(
      token: token,
      channelId: channelIdforcall, // Use unique channel ID
      userAccount: widget.callerUid,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> startCall(String receiverId) async {
    rtmService = RTMService();
    await rtmService.initialize(widget.callerUid);

    String callInvitation =
        "Incoming call from ${widget.contactname}, Channel ID: $channelIdforcall";
    await rtmService.sendMessage(receiverId, callInvitation);
    print("Start call initiated to $receiverId with message: $callInvitation");
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
                          ApiCallFunctions.instance.endcall(ids);
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RatingDialog(
                                onRatingSubmitted: (rating) {
                                  final ratemodel = RatingAgent.create(
                                    agent: widget.receiverUid,
                                    user: widget.callerUid,
                                    ratings: rating,
                                  );
                                  ApiCallFunctions.instance
                                      .rateagent(ratemodel);
                                  print('Rating selected: $rating');
                                },
                              );
                            },
                          );
                        },
                      )
                    : AfterAcceptCall(onEnd: () async {
                        await _engine.leaveChannel();
                        await _engine.release();
                        ApiCallFunctions.instance.endcall(ids);
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RatingDialog(
                              onRatingSubmitted: (rating) {
                                final ratemodel = RatingAgent.create(
                                  agent: widget.receiverUid,
                                  user: widget.callerUid,
                                  ratings: rating,
                                );
                                ApiCallFunctions.instance.rateagent(ratemodel);
                                print('Rating selected: $rating');
                              },
                             
                                
                            );
                          },
                        );
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
    print("RTM client initialized and logged in with user ID: $userId");
  }

  Future<void> sendMessage(String peerId, String message) async {
    try {
      RtmMessage rtmMessage = RtmMessage.fromText(message);
      await _rtmClient.sendMessageToPeer2(peerId, rtmMessage);
      print("Message sent to $peerId: $message");
    } catch (e) {
      print("Error sending message to $peerId: $e");
    }
  }

  void setOnMessageReceived(Function(String message, String peerId) callback) {
    onMessageReceived = callback;
  }
}


class RatingDialog extends StatefulWidget {
  final Function(int) onRatingSubmitted;

  RatingDialog({required this.onRatingSubmitted});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate the Call'),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _rating = index + 1;
              });
            },
            child: Icon(
              index < _rating ? Icons.favorite : Icons.favorite_border,
              color: index < _rating ? Colors.red : Colors.grey,
            ),
          );
        }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onRatingSubmitted(_rating);
            Navigator.of(context).pop();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
