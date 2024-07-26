import 'dart:developer';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/model_user_list/model_user_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_incomming.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:agora_rtm/agora_rtm.dart';

class ListViewUIAgent extends StatelessWidget {
  final ValueNotifier<List<ModelUserList>> _listAgentNotifier =
      ValueNotifier([]);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  final double height;
  final double width;

  ListViewUIAgent({
    super.key,
    required this.height,
    required this.width,
  });

  Future<void> _initializeRTMService(BuildContext context) async {
    final phoneno = await SharedPreferences.getInstance();
    final phoneusernumber = phoneno.getString("phone_number");
    final loginuserdetail = await ApiCallFunctions.instance
        .loginWithNumber(phoneusernumber.toString());
    logindetailslistcalling.value = loginuserdetail;

    AgoraRtmClient rtmClient = await AgoraRtmClient.createInstance(appId);
    rtmClient.onMessageReceived = (RtmMessage message, String peerId) {
      log("Private message from $peerId: ${message.text}");
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return AudioIncommingUI(
            name: peerId,
            userId: loginuserdetail.customerFirstName.toString(),
            //channelId: message.text,
          );
        },
      ));
    };

    await rtmClient.login(null, loginuserdetail.customerId.toString());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final agentlist = await ApiCallFunctions.instance.getUserModelList();
        _listAgentNotifier.value = agentlist.toList();
        await _initializeRTMService(context);
      },
    );

    return Center(
      child: Container(
        height: height - 370,
        width: width - 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ValueListenableBuilder(
          valueListenable: _listAgentNotifier,
          builder: (context, value, _) {
            return Column(
              children: [
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Color(0xffb42c44),
                  tabs: [
                    Tab(text: "All"),
                    Tab(text: 'Malayalam'),
                    Tab(text: 'Tamil'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildListView(value, 'All', context),
                      _buildListView(value, 'Malayalam', context),
                      _buildListView(value, 'Tamil', context),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildListView(
      List<ModelUserList> agentList, String category, BuildContext context) {
    final filteredItems = agentList.where((agent) {
      if (category == 'All') {
        return true;
      }
      return agent.languages?.toLowerCase() == category.toLowerCase();
    }).toList();

    return ListView.builder(
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          title: Text(
            "${item.customerFirstName}",
            style: const TextStyle(fontFamily: "Poppins-Regular"),
          ),
          subtitle: Text(
            "${item.customerEmail}",
            style: const TextStyle(fontFamily: "Poppins-Regular"),
          ),
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/images/avatarImage.png"),
            radius: 23,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () {
                  log("receiver id : ${item.customerId}");
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AudioOutgoingUI(
                        contactname: "${item.customerFirstName}",
                        callerUid:
                            "${logindetailslistcalling.value!.customerId}",
                        receiverUid: "${item.customerId}",
                        contactName: '', // Receiver UID
                      );
                    },
                  ));
                },
              ),
              const SizedBox(width: 10),
              Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(item.isOnline == true
                        ? "assets/images/online.png"
                        : "assets/images/offline.png"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: filteredItems.length,
    );
  }
}
