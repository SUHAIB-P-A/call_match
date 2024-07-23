import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';
import 'package:flutter/material.dart';

class ListViewUI extends StatelessWidget {
  final double height;
  final double width;

  const ListViewUI({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
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
                Tab(text: 'All'),
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

    return ListView.builder(
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          title: Text(
            item['name']!,
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
                        callerUid: '45', // Replace with actual caller UID
                        receiverUid: item['uid'], contactName: '', // Receiver UID
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
      itemCount: filteredItems.length,
    );
  }
}
