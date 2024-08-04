import 'package:call_match/core/imagepath.dart';
import 'package:call_match/data/ChatMessage/chat_message.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/model_agent_list/model_agent_list.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agentchat/chat_screen.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/chat_screen.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/add_coin_and_display.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactListScreen extends StatelessWidget {
  ContactListScreen({super.key});
  final ValueNotifier<List<ModelAgentList>> _listAgentNotifier =
      ValueNotifier([]);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final phoneno = await SharedPreferences.getInstance();
        final phoneusernumber = phoneno.getString("phone_number");
        final loginuserdetail = await ApiCallFunctions.instance
            .loginWithNumber(phoneusernumber.toString());
        logindetailslistcalling.value = loginuserdetail;
        //await player1.setSource(AssetSource('assets/audio/Outgoing.mp3'));
        final agentlist = await ApiCallFunctions.instance.getAgentModelList();
        _listAgentNotifier.value = agentlist.toList();
      },
    );

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        //backgroundColor: const Color(0xffffdce0),
        body: Stack(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(backgroundimage),
            ),
          ),
          child: const SizedBox.expand(),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
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
                          color: Colors.white),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: height - 274,
                    width: width - 85,
                    decoration: BoxDecoration(
                      color: Colors.transparent.withOpacity(0.30),
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
                          itemCount:
                              value.length, // Replace with your contact count
                          itemBuilder: (context, index) {
                            final item = value[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: InkWell(
                                onTap: () {
                                  if (item.isOnline == true &&
                                      walletnotifier.value!.messagesRemaining !=
                                          null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreenAgent(
                                                contactName:
                                                    "${item.customerFirstName} ${item.customerLastName}",
                                                id1:
                                                    "${logindetailslistcalling.value!.customerId}",
                                                id2: "${item.customerId}",
                                              )),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          item.isOnline == false
                                              ? "${item.customerFirstName} is offline and cannot have conversation."
                                              : "You don't have enough coins to make a chat.",
                                        ),
                                        backgroundColor: Colors.red,
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                              "assets/images/avatarImage.png"),
                                          radius: 30,
                                        ),
                                        Positioned(
                                          left: 45,
                                          top: 40,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: AssetImage(item
                                                            .isOnline ==
                                                        true
                                                    ? "assets/images/online.png"
                                                    : "assets/images/offline.png"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${item.customerFirstName} ${item.customerLastName}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Last message preview', // Replace with actual last message
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '12:30 PM', // Replace with actual timestamp
                                          style: TextStyle(
                                            color: Colors.grey,
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
                                            borderRadius:
                                                BorderRadius.circular(12),
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
                                    const SizedBox(
                                      width: 8,
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
          ),
        ),
      ],
    ));
  }
}
