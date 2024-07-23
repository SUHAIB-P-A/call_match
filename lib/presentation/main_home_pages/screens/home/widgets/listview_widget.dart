import 'dart:developer';

import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/model_agent_list/model_agent_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListViewUI extends StatelessWidget {
  final ValueNotifier<List<ModelAgentList>> _listAgentNotifier =
      ValueNotifier([]);
  final double height;
  final double width;

  ListViewUI({
    super.key,
    required this.height,
    required this.width,
  });
  final List<ModelAgentList> _listagent = [];
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final agentlist = await ApiCallFunctions.instance.getAgentModelList();
        agentlist.toList();
        log(agentlist.toString());
        print(agentlist.toList());
        _listAgentNotifier.value = agentlist;
      },
    );
    // Sample data with UIDs
    final List<Map<String, dynamic>> items = [
      {
        'name': 'Name 1',
        'location': 'Mumbai',
        'category': 'All',
        'uid': 'user1_uid'
      },
      {
        'name': 'Name 2',
        'location': 'Kochi',
        'category': 'Malayalam',
        'uid': 'user2_uid'
      },
      {
        'name': 'Name 3',
        'location': 'Chennai',
        'category': 'Tamil',
        'uid': 'user3_uid'
      },
      // Add more items as needed
    ];

    return Center(
      child: Container(
        height: height - 370,
        width: width - 85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xffb42c44), // Primary color of the app
              tabs: [
                Tab(text: "alll"),
                Tab(text: 'Malayalam'),
                Tab(text: 'Tamil'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildListView(items, 'All', context),
                  _buildListView(items, 'Malayalam', context),
                  _buildListView(items, 'Tamil', context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(
      List<Map<String, dynamic>> items, String category, BuildContext context) {
    // Filter items based on the selected category
    final filteredItems = items.where((item) {
      if (category == 'All') {
        return true;
      }
      return item['category'] == category;
    }).toList();

    return ValueListenableBuilder(
      valueListenable: _listAgentNotifier,
      builder: (context, agentNotifier, _) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return ListTile(
              title: Text(
                "agentNotifier",
                style: const TextStyle(fontFamily: "Poppins-Regular"),
              ),
              subtitle: Text(
                item['location']!,
                style: const TextStyle(fontFamily: "Poppins-Regular"),
              ),
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/736x/7a/57/08/7a5708d3347e1965a6df017fdb960965.jpg"),
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
                            contactname: item['name']!,
                            callerUid: '40', // Replace with actual caller UID
                            receiverUid: item['uid'], // Receiver UID
                          );
                        },
                      ));
                    },
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/online.png"))),
                  ),
                ],
              ),
            );
          },
          itemCount: agentNotifier.length,
        );
      },
    );
  }
}
