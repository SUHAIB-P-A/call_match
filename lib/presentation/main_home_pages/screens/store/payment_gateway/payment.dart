import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/gateway_list.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class PaymentScreenUI extends StatelessWidget {
  static const routename = "payment-screen";
  const PaymentScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffffdce0),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchAndMenu(),
            ],
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileUI(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GatewayList(),
        ],
      ),
    );
  }
}
