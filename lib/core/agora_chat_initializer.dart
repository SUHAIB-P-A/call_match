import 'package:agora_chat_sdk/agora_chat_sdk.dart';

class AgoraChatInitializer {
  static Future<void> initializeAgoraChat() async {
    // Initialize the Agora Chat SDK
    await ChatClient.getInstance.init(
      ChatOptions(
        appKey:
            '9efc1378f1864523a3fda344f739151b', // Replace with your Agora Chat App Key
      ),
    );
  }
}
