import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/widgets/list_tile_for_app.dart';
import 'package:flutter/material.dart';

class GatewayList extends StatelessWidget {
  const GatewayList({
    super.key,
  });

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
          const SizedBox(height: 05,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Cards, UPI & More',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image8.png",
              title: "UPI",
              subOptions: [
                {
                  'imgpath': 'assets/images/AI_Image7.png',
                  'name': 'Google Pay',
                },
                {'imgpath': 'assets/images/AI_Image6.png', 'name': 'PhonePe'},
                {
                  'imgpath': 'assets/images/AI_Image5.png',
                  'name': 'Paytm',
                },
                {
                  'imgpath': 'assets/images/AI_Image4.png',
                  'name': 'Others',
                }
              ],
              child: Text("Pay with installed app, or use others"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image3_1.png",
              title: "Netbanking",
              child: Text("All Indian banks"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: PaymentOption(
              imgpath: "assets/images/AI_Image 2.png",
              title: "Wallet",
              child: Text("Paytm & Freecharge"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("₹ 6,000"),
                    GestureDetector(
                      onTap: () {},
                      child: const Text("View details"),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffb42c44),
                    minimumSize: const Size(
                      150,
                      40,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
