import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/green_button_for_payment.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

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
                  const SearchAndMenu(),
                  const SizedBox(
                    height: 20,
                  ),
                  const ProfileUI(),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "Coin Pack",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GreenButtonForPayment(
                      height: height,
                      width: width,
                      coinPriceNotifier: coinPriceNotifier,
                      showPaymentScreenNotifier: showPaymentScreenNotifier)
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
