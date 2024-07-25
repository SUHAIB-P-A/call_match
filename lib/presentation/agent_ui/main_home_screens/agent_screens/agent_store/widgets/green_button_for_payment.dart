import 'package:call_match/presentation/main_home_pages/screens/store/widget/coin_price.dart';
import 'package:flutter/material.dart';

class GreenButtonForPayment extends StatelessWidget {
  const GreenButtonForPayment({
    super.key,
    required this.coinPriceNotifier,
    required this.showPaymentScreenNotifier,
  });

  final ValueNotifier<String> coinPriceNotifier;
  final ValueNotifier<bool> showPaymentScreenNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoinPriceUI(
          coinprice: "499",
          coins: "500",
          onPressed: () {
            coinPriceNotifier.value = "500";
            showPaymentScreenNotifier.value = true;
          },
        ),
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
                        coinPriceNotifier.value = "4,000";
                        showPaymentScreenNotifier.value = true;
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
        CoinPriceUI(
          coinprice: "5999",
          coins: "6000",
          onPressed: () {
            coinPriceNotifier.value = "6,000";
            showPaymentScreenNotifier.value = true;
          },
        ),
      ],
    );
  }
}
