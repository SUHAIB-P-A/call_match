import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/model_user_list/model_user_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:flutter/material.dart';

class ListViewUIAgent extends StatelessWidget {
  final ValueNotifier<List<ModelUserList>> _listAgentNotifieragent =
      ValueNotifier([]);
  final double height;
  final double width;

  ListViewUIAgent({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final agentlist = await ApiCallFunctions.instance.getUserModelList();
        agentlist.toList();
        _listAgentNotifieragent.value = agentlist;
      },
    );
    // Sample data with UIDs

    return Center(
      child: Container(
          height: height - 370,
          width: width - 85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ValueListenableBuilder(
            valueListenable: _listAgentNotifieragent,
            builder: (
              context,
              value,
              _,
            ) {
              return Column(
                children: [
                  const TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor:
                        Color(0xffb42c44), // Primary color of the app
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
          )),
    );
  }

  Widget _buildListView(
      List<ModelUserList> agentList, String category, BuildContext context) {
    // Filter items based on the selected category
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
                  // Here you pass both UIDs to the calling screen
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return AudioOutgoingUI(
                        contactname: "${item.customerFirstName}",
                        callerUid: '40', // Replace with actual caller UID
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
