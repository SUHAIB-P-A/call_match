// import 'dart:developer';

// import 'package:call_match/data/ChatMessage/chat_message.dart';
// import 'package:call_match/data/agentlist/data.dart';
// import 'package:call_match/data/send_chat_model/send_chat_model.dart';
// import 'package:flutter/material.dart';

// class ChatScreen extends StatelessWidget {
//   final String contactName;
//   final String id1;
//   final String id2;

//   final ValueNotifier<List<ChatMessage>> _messages = ValueNotifier([]);

//   ChatScreen({
//     super.key,
//     required this.contactName,
//     required this.id1,
//     required this.id2,
//   });

//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       fetchMessages();
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(contactName),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ValueListenableBuilder<List<ChatMessage>>(
//               valueListenable: _messages,
//               builder: (context, messages, child) {
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Align(
//                         alignment: message.sender!.customerId == int.parse(id1)
//                             ? Alignment.centerLeft
//                             : Alignment.centerRight,
//                         child: Container(
//                           padding: const EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: message.sender!.customerId == int.parse(id1)
//                                 ? Colors.blue[100]
//                                 : Colors.green[100],
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 message.message ?? '',
//                                 style: const TextStyle(fontSize: 16.0),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 message.createdAt ?? '',
//                                 style: const TextStyle(
//                                     fontSize: 12.0, color: Colors.grey),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Type a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void fetchMessages() async {
//     log('Calling getChatMessages method');
//     try {
//       final messages = await ApiCallFunctions().getChatMessages(id1, id2);
//       log('Messages fetched: ${messages.length}');
//       _messages.value = messages;
//     } catch (e) {
//       log('Error fetching messages: $e');
//     }
//   }

//   void sendMessage() async {
//     if (_controller.text.isNotEmpty) {
//       try {
//         final messagemodel = SendChatModel.create(
//           user1: id1,
//           user2: id2,
//           message: _controller.text,
//         );
//         await ApiCallFunctions().sendMessage(messagemodel);
//         fetchMessages();
//         _controller.clear();
//       } catch (e) {
//         log('Error sending message: $e');
//       }
//     }
//   }
// }
