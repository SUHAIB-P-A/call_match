import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/model_user_list/model_user_list.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/chat_screen.dart';
import 'package:flutter/material.dart';

class ContactListScreenAgent extends StatelessWidget {
  ContactListScreenAgent({super.key});
  final ValueNotifier<List<ModelUserList>> _listAgentNotifier =
      ValueNotifier([]);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final agentlist = await ApiCallFunctions.instance.getUserModelList();
        _listAgentNotifier.value = agentlist.toList();
      },
    );

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
              child: ValueListenableBuilder(
                valueListenable: _listAgentNotifier,
                builder: (
                  context,
                  value,
                  _,
                ) {
                  return ListView.builder(
                    itemCount: value.length, // Replace with your contact count
                    itemBuilder: (context, index) {
                      final item = value[index];
                      final firstName = item.customerFirstName ?? 'N/A';
                      final lastName = item.customerLastName ?? 'N/A';
                      final id = item.customerId ?? 'N/A';
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreenAgent(
                                  contactName: "$firstName $lastName",
                                  id1:
                                      "${logindetailslistcalling.value!.customerId}??"
                                      "",
                                  id2: "$id",
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
                                  'C${index + 1}',
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
                                      '${item.customerFirstName} ${item.customerLastName}',
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
                                    child: Text(
                                      '${item.languages}', // Replace with actual unread message count
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
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
