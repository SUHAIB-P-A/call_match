import 'package:call_match/core/agora_config.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initializeAgora();
  }

  Future<void> _initializeAgora() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
      ),
    );
    // Join a channel (replace 'test_channel' with your channel name)
    await _engine.joinChannel(
      token: "",
      channelId: 'test_channel',
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: _onCallButtonPressed,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Replace with your message count
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Message $index'),
                );
              },
            ),
          ),
          _buildMessageInputBar(),
        ],
      ),
    );
  }

  Widget _buildMessageInputBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              // Implement send message functionality here
            },
          ),
        ],
      ),
    );
  }

  void _onCallButtonPressed() {
    // Implement call functionality here
  }
}
