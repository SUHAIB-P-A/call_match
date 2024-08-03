import 'dart:async';
import 'dart:developer';
import 'package:call_match/data/ChatMessage/chat_message.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/send_chat_model/send_chat_model.dart';
import 'package:flutter/material.dart';

class ChatScreenAgent extends StatelessWidget {
  final String contactName;
  final String id1;
  final String id2;

  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<List<ChatMessage>> _messagesNotifier = ValueNotifier([]);
  Timer? _pollingTimer;

  ChatScreenAgent({
    super.key,
    required this.contactName,
    required this.id1,
    required this.id2,
  });

  Future<void> fetchMessages() async {
    log('Calling getChatMessages method');
    try {
      final messages =
          await ApiCallFunctions.instance.getChatMessages(id1, id2);
      log('Messages fetched: ${messages.length}');
      _messagesNotifier.value = messages;
    } catch (e) {
      log('Error fetching messages: $e');
      _messagesNotifier.value = [];
    }
  }

  void sendMessage() async {
    if (_controller.text.isNotEmpty) {
      try {
        final messagemodel = SendChatModel.create(
          user1: id1,
          user2: id2,
          message: _controller.text,
        );
        await ApiCallFunctions().sendMessage(messagemodel);
        _controller.clear();
        // Re-fetch messages to update the list
        await fetchMessages();
      } catch (e) {
        log('Error sending message: $e');
      }
    }
  }

  void startPolling() {
    _pollingTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await fetchMessages();
    });
  }

  void stopPolling() {
    _pollingTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchMessages();
      startPolling();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          contactName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffb42c44),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            stopPolling();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: _messagesNotifier,
              builder: (context, messages, _) {
                if (messages.isEmpty) {
                  return const Center(child: Text('No messages'));
                }
                return ListView.builder(
                  reverse: false,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final senderId = message.sender?.customerId;
                    final isSender =
                        senderId != null && senderId == int.parse(id1);

                    return Align(
                      alignment: isSender
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        decoration: BoxDecoration(
                          color: isSender
                              ? const Color(0xffb42c44)
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20).subtract(
                            BorderRadius.only(
                              bottomLeft: Radius.circular(isSender ? 0 : 20),
                              bottomRight: Radius.circular(isSender ? 20 : 0),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message ?? '',
                              style: TextStyle(
                                  color:
                                      isSender ? Colors.white : Colors.black),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              message.createdAt ?? '',
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, color: Colors.grey),
                    onPressed: () {
                      // Implement camera functionality
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) {
                        // No need to update _isComposing since it's not a StatefulWidget
                      },
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12, right: 8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: _controller.text.isNotEmpty
                        ? const Color(0xffb42c44)
                        : Colors.grey,
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
