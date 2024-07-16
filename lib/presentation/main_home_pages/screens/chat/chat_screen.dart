import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_incomming.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String contactName;

  const ChatScreen({super.key, required this.contactName});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = []; // List to hold messages
  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false; // Flag to track if the user is typing

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: Text(
          widget.contactName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffb42c44),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call, color: Colors.white),
            onPressed: () {
              // Implement video call functionality
              _startVideoCall();
            },
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.white),
            onPressed: () {
              // Implement voice call functionality
              _startVoiceCall();
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Open drawer
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
              reverse: true, // To start from the bottom
              itemBuilder: (context, index) {
                final message = _messages[index];
                final bool isMe = message['sender'] == 'me'; // Identify sender

                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
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
                      message['text'],
                      style:
                          TextStyle(color: isMe ? Colors.white : Colors.black),
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
      // Add message to list (simulating sending)
      setState(() {
        _messages.insert(0, {'sender': 'me', 'text': text});
      });
      _controller.clear();
      // For demo, simulate receiving a message after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages
              .insert(0, {'sender': widget.contactName, 'text': 'Hi there!'});
        });
      });
    }
  }

  void _startVideoCall() {
    // Implement video call logic
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AudioIncommingUI(name: widget.contactName);
      },
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Starting video call...')),
    );
  }

  void _startVoiceCall() {
    // Implement voice call logic
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AudioOutgoingUI(contactname: widget.contactName);
      },
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      
      const SnackBar(content: Text('Starting voice call...')),
    );
  }
}
