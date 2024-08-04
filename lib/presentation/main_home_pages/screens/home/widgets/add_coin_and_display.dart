import 'dart:developer';

import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/wallet_details/wallet_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final ValueNotifier<WalletDetails?> walletnotifier = ValueNotifier(null);

class AddCoinDisplayUI extends StatelessWidget {
  AddCoinDisplayUI({
    super.key,
  });

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
          final wallet = await ApiCallFunctions.instance
              .getWalletDetails("${logindetailslistcalling.value!.customerId}");
          walletnotifier.value = wallet;
        } catch (e) {
          // Handle any errors during fetching
          log('Failed to load wallet details 1: $e');
        }
      },
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              //height: 39,
              decoration: const BoxDecoration(
                color: Color.fromARGB(179, 236, 235, 235),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(20, 20),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Chat",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/PROTOTYPE CALLMATCH 003-03.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: walletnotifier,
                        builder: (
                          context,
                          value,
                          _,
                        ) {
                          if (value != null) {
                            return Text(
                              '${value.messagesRemaining}',
                              style: const TextStyle(
                                fontFamily: "Poppins-Regular",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          } else {
                            return const Text(
                              '',
                              style: TextStyle(
                                fontFamily: "Poppins-Regular",
                                fontSize: 16,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(
          width: 15,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              //height: 39,
              decoration: const BoxDecoration(
                color: Color.fromARGB(179, 236, 235, 235),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(20, 20),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Call",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/PROTOTYPE CALLMATCH 003-03.png"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ValueListenableBuilder(
                        valueListenable: walletnotifier,
                        builder: (
                          context,
                          value,
                          _,
                        ) {
                          if (value != null) {
                            return Text(
                              '${value.walletCoins}',
                              style: const TextStyle(
                                  fontFamily: "Poppins-Regular",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            );
                          } else {
                            return const Text(
                              '',
                              style: TextStyle(
                                fontFamily: "Poppins-Regular",
                                fontSize: 16,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
