import 'dart:developer';
import 'dart:ffi';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:call_match/core/agoraconfig.dart';
import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_store/widgets/green_button_for_payment.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_store/widgets/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_incomming.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/curve_ui_widget.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/green_button_for_payment.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreScreenAgent extends StatelessWidget {
  StoreScreenAgent({super.key});
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initializeRTMService(context);
    });
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    ValueNotifier<bool> showPaymentScreenNotifier = ValueNotifier(false);
    ValueNotifier<String> coinPriceNotifier = ValueNotifier('');

    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: PopScope(
        canPop: !showPaymentScreenNotifier.value,
        onPopInvoked: (didPop) async {
          if (!didPop) {
            showPaymentScreenNotifier.value = false;
          }
        },
        child: ValueListenableBuilder(
          valueListenable: showPaymentScreenNotifier,
          builder: (
            context,
            showPaymentScreen,
            _,
          ) {
            if (showPaymentScreen) {
              return ValueListenableBuilder(
                valueListenable: coinPriceNotifier,
                builder: (
                  context,
                  coinPrice,
                  _,
                ) {
                  return PaymentScreenUI(
                    coinpriceone: coinPrice,
                    onBack: () {
                      showPaymentScreenNotifier.value = false;
                    },
                  );
                },
              );
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    CurveShapeUI(width: width),
                    const SizedBox(
                      height: 20,
                    ),
                    GreenButtonForPaymentAgent(
                        coinPriceNotifier: coinPriceNotifier,
                        showPaymentScreenNotifier: showPaymentScreenNotifier,
                        height: height,
                        width: width)
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _initializeRTMService(BuildContext context) async {
    final phoneno = await SharedPreferences.getInstance();
    final phoneusernumber = phoneno.getString("phone_number");
    final loginuserdetail = await ApiCallFunctions.instance
        .loginWithNumber(phoneusernumber.toString());
    logindetailslistcalling.value = loginuserdetail;

    AgoraRtmClient rtmClient = await AgoraRtmClient.createInstance(appId);
    rtmClient.onMessageReceived = (RtmMessage message, String peerId) {
      log("Private message from $peerId: ${message.text}");

      // Extract channel ID from the message
      final parts = message.text.split(', Channel ID: ');
      if (parts.length == 2) {
        final channelId = parts[1];
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return AudioIncommingUI(
              name: peerId,
              userId: loginuserdetail.customerFirstName.toString(),
              channelId: channelId, // Pass the extracted channel ID
            );
          },
        ));
      }
    };

    await rtmClient.login(null, loginuserdetail.customerId.toString());
  }
}
