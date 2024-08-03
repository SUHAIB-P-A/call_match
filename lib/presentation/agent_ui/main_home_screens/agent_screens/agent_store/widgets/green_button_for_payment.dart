import 'dart:developer';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/wallet_details/wallet_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreenButtonForPaymentAgent extends StatelessWidget {
  GreenButtonForPaymentAgent({
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
  final ValueNotifier<WalletDetails?> walletnotifier = ValueNotifier(null);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        try {
          final phoneno = await SharedPreferences.getInstance();
          final phoneusernumber = phoneno.getString("phone_number");
          final loginuserdetail = await ApiCallFunctions.instance
              .loginWithNumber(phoneusernumber.toString());
          logindetailslistcalling.value = loginuserdetail;

          final walletList = await ApiCallFunctions.instance
              .getWalletDetails("${logindetailslistcalling.value!.customerId}");
          walletnotifier.value = walletList;
        } catch (e) {
          // Handle any errors during fetching
          log('Failed to load wallet details 1: $e');
        }
      },
    );
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: Container(
            height: height - 600,
            width: width - 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const TabBar(
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(
                      text: "Call",
                    ),
                    Tab(
                      text: "Chat",
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
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: height - 570,
          width: width - 65,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ValueListenableBuilder<WalletDetails?>(
            valueListenable: walletnotifier,
            builder: (context, walletList, _) {
              if (walletList == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Total amount for withdrawal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${walletList.totalamount}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final totalamountvalue =
                            double.parse("${walletList.totalamount}");
                        if (totalamountvalue >= 5000) {
                          await ApiCallFunctions.instance.withdrawal(
                              "${logindetailslistcalling.value!.customerId}");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Withdrawal successful: ${walletList.totalamount}"),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Insufficient amount to withdraw. Minimum required is 5000."),
                            ),
                          );
                        }
                      },
                      child: const Text("Withdraw"),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCallPackView() {
    return ValueListenableBuilder<WalletDetails?>(
      valueListenable: walletnotifier,
      builder: (context, walletList, _) {
        if (walletList == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Call amount: ${walletList.callAmount}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Total minutes: ${walletList.totalMinutes}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatPackView() {
    return ValueListenableBuilder<WalletDetails?>(
      valueListenable: walletnotifier,
      builder: (context, walletList, _) {
        if (walletList == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chat amount: ${walletList.chatAmount}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Total messages received: ${walletList.totalMessagesReceived}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
