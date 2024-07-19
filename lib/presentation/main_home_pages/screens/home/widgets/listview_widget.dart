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
    // Sample data based on category
    final List<Map<String, String>> items = [
      {'name': 'Name 1', 'location': 'Mumbai', 'category': 'All'},
      {'name': 'Name 2', 'location': 'Kochi', 'category': 'Malayalam'},
      {'name': 'Name 3', 'location': 'Chennai', 'category': 'Tamil'},
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
            TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor:
                  const Color(0xffb42c44), // Primary color of the app
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Malayalam'),
                Tab(text: 'Tamil'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildListView(items, 'All'),
                  _buildListView(items, 'Malayalam'),
                  _buildListView(items, 'Tamil'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Map<String, String>> items, String category) {
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
                  // Implement call functionality
                },
              ),
              const SizedBox(width: 10),
              Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    scale: 0.5,
                    image: AssetImage("assets/images/love_symbol.png"),
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
