import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/gateway_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/coin_price.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class PaymentScreenUI extends StatelessWidget {
  static const routename = "payment-screen";
  final String coinpriceone;
  const PaymentScreenUI({
    super.key,
    required this.coinpriceone
    });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchAndMenu(),
            ],
          ),
          const SizedBox(
            height: 45,
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
          GatewayList(coins: coinpriceone,),
        ],
      ),
    );
  }
}
