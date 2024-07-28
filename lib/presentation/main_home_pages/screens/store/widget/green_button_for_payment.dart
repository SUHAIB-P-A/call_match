import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/call_package/call_package.dart';
import 'package:call_match/data/chatpack_age/chatpack_age.dart';
import 'package:flutter/material.dart';

class GreenButtonForPayment extends StatelessWidget {
  GreenButtonForPayment({
    super.key,
    required this.coinPriceNotifier,
    required this.showPaymentScreenNotifier,
    required this.height,
    required this.width,
  });

  final ValueNotifier<String> coinPriceNotifier;
  final ValueNotifier<bool> showPaymentScreenNotifier;
  final double height;
  final double width;
  final ValueNotifier<List<ChatpackAge>> _chatpackNotifier = ValueNotifier([]);
  final ValueNotifier<List<CallPackage>> _callpackNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        //await player2.setSource(AssetSource("assets/audio/Outgoing.mp3"));
        final chatpacklist = await ApiCallFunctions.instance.chatpackage();
        _chatpackNotifier.value = chatpacklist.toList();
        final callpacklist = await ApiCallFunctions.instance.callpackage();
        _callpackNotifier.value = callpacklist.toList();
      },
    );
    return DefaultTabController(
      length: 2,
      child: Container(
        height: height - 625,
        width: width - 65,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: "call pack",
                ),
                Tab(
                  text: "chat pack",
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildCallPackView(),
                  _buildChatPackView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallPackView() {
    return ValueListenableBuilder(
      valueListenable: _callpackNotifier,
      builder: (
        context,
        callpackages,
        _,
      ) {
        if (callpackages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            final callpack = callpackages[index];
            final packagePrice = callpack.packagePrice ?? "";
            final totalCoins = callpack.totalCoins ?? "";
            return ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
              ),
              title: Text("$totalCoins"),
              trailing: Container(
                height: 25,
                width: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff59982B),
                      Color(0xff99DD43),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    coinPriceNotifier.value = "$packagePrice";
                    showPaymentScreenNotifier.value = true;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(
                      100,
                      25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        11,
                      ),
                    ),
                  ),
                  child: Text(
                    "Rs $packagePrice",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChatPackView() {
    return ValueListenableBuilder(
      valueListenable: _chatpackNotifier,
      builder: (
        context,
        chatpack,
        _,
      ) {
        if (chatpack.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            final chatpacks = chatpack[index];
            final messagecount = chatpacks.messageCount ?? "";
            final price = chatpacks.packagePrice ?? "";
            return ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
              ),
              title: Text("$messagecount"),
              trailing: Container(
                height: 25,
                width: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff59982B),
                      Color(0xff99DD43),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    coinPriceNotifier.value = "$price";
                    showPaymentScreenNotifier.value = true;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(
                      100,
                      25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        11,
                      ),
                    ),
                  ),
                  child: Text(
                    "Rs $price",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
