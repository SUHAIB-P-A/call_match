import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/button_and_coin.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/coin_price.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const SearchAndMenu(),
          const SizedBox(
            height: 20,
          ),
          const ProfileUI(),
          const SizedBox(
            height: 40,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Buy Coins",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text("Wallet"),
                  Text("─────────"),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Text("Earnings"),
                  Text("─────────"),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/coin2.png"),
                  ),
                ),
              ),
              const Text(
                "100 Coins",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
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
          const CoinPriceUI(coinprice: "499", coins: "500"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
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
                          "4000 coin",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 60,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/POPULAR5.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 25,
                      width: 105,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff59982B),
                            Color(0xff99DD43),
                          ], // Your gradient colors here
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentScreenUI(coinpriceone: "4,000"),
                                ),
                              );
                          //Navigator.of(context).pushReplacementNamed(PaymentScreenUI.routename);
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
                        child: const Text(
                          "Rs. 3999",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const CoinPriceUI(coinprice: "5999", coins: "6000"),
        ],
      ),
    );
  }
}


