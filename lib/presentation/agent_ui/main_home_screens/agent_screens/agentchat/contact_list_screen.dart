import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:call_match/data/model_user_list/model_user_list.dart';

class ContactListScreenAgent extends StatefulWidget {
  const ContactListScreenAgent({super.key});

  @override
  _ContactListScreenAgentState createState() => _ContactListScreenAgentState();
}

class _ContactListScreenAgentState extends State<ContactListScreenAgent> {
  final ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  List<ModelUserList> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await apiCallFunctions.getUserModelList();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, maybe show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Chats",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "MyriadPro",
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          Center(
            child: Container(
              height: height - 274,
              width: width - 85,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        final user = _users[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                      contactName:
                                          '${user.customerFirstName} ${user.customerLastName}',
                                      receiverId: user.customerId ?? 0),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xffd1d1d1),
                                  child: Text(
                                    user.customerFirstName?[0] ?? 'U',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.customerFirstName} ${user.customerLastName}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Last message preview', // Replace with actual last message
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '12:30 PM', // Replace with actual timestamp
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xffb42c44), // Primary color of the app
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Text(
                                        '2', // Replace with actual unread message count
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
