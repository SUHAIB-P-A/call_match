import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/gateway_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class PaymentScreenUI extends StatelessWidget {
  static const routename = "payment-screen";
  final String coinpriceone;
  final VoidCallback onBack;
  const PaymentScreenUI({super.key, required this.coinpriceone, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        onBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffdce0),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      onBack();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.red,
                    ),
                  ),
                  const SearchAndMenu(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileUI(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GatewayList(
                coins: coinpriceone,
              ),
              //const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
