import 'package:flutter/material.dart';
import 'package:call_match/data/model_agent_list/model_agent_list.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'chat_screen.dart';
import 'dart:developer';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final ApiCallFunctions apiCallFunctions = ApiCallFunctions();
  List<ModelAgentList> _agents = [];

  @override
  void initState() {
    super.initState();
    fetchAgents();
  }

  void fetchAgents() async {
    try {
      final agents = await apiCallFunctions.getAgentModelList();
      setState(() {
        _agents = agents;
      });
    } catch (e) {
      log('Error fetching agents: $e');
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
              child: ListView.builder(
                itemCount: _agents.length,
                itemBuilder: (context, index) {
                  final agent = _agents[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              contactName: '${agent.customerFirstName} ${agent.customerLastName}',
                              receiverId: agent.customerId ?? 0, // Use customerId as receiverId
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color(0xffd1d1d1),
                            child: Text(
                              agent.customerFirstName != null ? agent.customerFirstName![0] : 'A',
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${agent.customerFirstName} ${agent.customerLastName}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  agent.customerEmail ?? 'No email provided',
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
                                agent.isOnline != null && agent.isOnline! ? 'Online' : 'Offline',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xffb42c44),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  agent.languages ?? 'N/A',
                                  style: const TextStyle(
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
