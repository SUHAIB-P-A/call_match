import 'package:call_match/data/ChatMessage/chat_message.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;
  final int receiverId; // ID of the agent

  const ChatScreen({
    super.key,
    required this.contactName,
    required this.receiverId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;
  int? _loggedInUserId;

  final ApiCallFunctions apiCallFunctions = ApiCallFunctions();

  @override
  void initState() {
    super.initState();
    _fetchLoggedInUserId();
  }

  Future<void> _fetchLoggedInUserId() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final phoneNumber = prefs.getString("phone_number");
      if (phoneNumber != null) {
        final loginUserDetail = await apiCallFunctions.loginWithNumber(phoneNumber);
        setState(() {
          _loggedInUserId = loginUserDetail.customerId;
        });
        fetchMessages();
      } else {
        log('Phone number not found in shared preferences');
      }
    } catch (e) {
      log('Error fetching logged-in user ID: $e');
    }
  }

  void fetchMessages() async {
    if (_loggedInUserId == null) return;

    log('Calling getChatMessages method');
    try {
      final messages = await apiCallFunctions.getChatMessages(_loggedInUserId!, widget.receiverId);
      log('Messages fetched: ${messages.length}');
      setState(() {
        _messages.clear(); // Clear old messages
        _messages.addAll(messages); // Add new messages
      });
    } catch (e) {
      log('Error fetching messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.contactName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffb42c44),
        actions: [
          // Removed the voice call button
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isMe = message.sender?.customerId == _loggedInUserId;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xffb42c44) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20).subtract(
                        BorderRadius.only(
                          bottomLeft: Radius.circular(isMe ? 0 : 20),
                          bottomRight: Radius.circular(isMe ? 20 : 0),
                        ),
                      ),
                    ),
                    child: Text(
                      message.message ?? '',
                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
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
                  const Icon(Icons.insert_emoticon, color: Colors.grey),
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: Colors.grey),
                    onPressed: () {
                      // Implement attachment functionality
                    },
                  ),
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
                        setState(() {
                          _isComposing = text.isNotEmpty;
                        });
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
                    color: _isComposing ? const Color(0xffb42c44) : Colors.grey,
                    onPressed: _isComposing ? _sendMessage : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final String text = _controller.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.insert(0, ChatMessage(
          sender: LoginedUser(customerId: _loggedInUserId!, username: 'me'),
          message: text,
          createdAt: DateTime.now().toString(),
        ));
      });
      _controller.clear();
      // For demo purposes, simulate receiving a message after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages.insert(0, ChatMessage(
            sender: LoginedUser(customerId: widget.receiverId, username: widget.contactName),
            message: 'Hi there!',
            createdAt: DateTime.now().toString(),
          ));
        });
      });
    }
  }
}
