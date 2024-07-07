import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:flutter/material.dart';

class CoinPriceUI extends StatelessWidget {
  final String coinprice;
  final String coins;
  final String? imagepath;
  const CoinPriceUI({
    super.key,
    required this.coinprice,
    required this.coins,
    this.imagepath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Text(
                    "$coins coin",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  )
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
                             PaymentScreenUI(coinpriceone: coinprice),
                      ),
                    );                  },
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
                  child: Text(
                    "Rs. $coinprice",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
