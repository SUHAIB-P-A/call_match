import 'dart:core';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/button_and_coin.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/list_tile_for_app.dart';
import 'package:flutter/material.dart';

class GatewayList extends StatelessWidget {
  final String? package;
  final String coins;
  final int? packageId; // Add this line
  const GatewayList({super.key, required this.coins, this.packageId,this.package});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 05,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Cards, UPI & More',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image9.png",
              title: "  Card",
              child: Container(
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/AI_Image (2).png"),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              package: package,
              packageId: packageId,
              price: double.parse(coins),
              imgpath: "assets/images/AI_Image8.png",
              title: "UPI",
              subOptions: const [
                {
                  'imgpath': 'assets/images/AI_Image7.png',
                  'name': 'Google Pay',
                },
                {
                  'imgpath': 'assets/images/AI_Image6.png',
                  'name': 'PhonePe',
                },
                {
                  'imgpath': 'assets/images/AI_Image5.png',
                  'name': 'Paytm',
                },
                {
                  'imgpath': 'assets/images/AI_Image4.png',
                  'name': 'Others',
                }
              ],
              child: const Text("Pay with installed app, or use others"),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image3_1.png",
              title: "Netbanking",
              child: const Text("All Indian banks"),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image 2.png",
              title: "Wallet",
              child: const Text("Paytm & Freecharge"),
            ),
          ),
          PayButtonCoins(
            coinprice: coins,
          ),
        ],
      ),
    );
  }
}
