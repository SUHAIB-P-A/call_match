import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_store/widgets/green_button_for_payment.dart';
import 'package:call_match/presentation/agent_ui/main_home_screens/agent_screens/agent_store/widgets/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/green_button_for_payment.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreScreenAgent extends StatelessWidget {
  const StoreScreenAgent({super.key});

  @override
  Widget build(BuildContext context) {
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
              return Column(
                children: [
                  const SearchAndMenuAgent(),
                  GreenButtonForPaymentAgent(
                      coinPriceNotifier: coinPriceNotifier,
                      showPaymentScreenNotifier: showPaymentScreenNotifier,
                      height: height,
                      width: width)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
