import 'package:flutter/material.dart';

class PayButtonCoins extends StatelessWidget {
  final String coinprice;
  const PayButtonCoins({
    super.key,
    required this.coinprice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text("₹$coinprice"),
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
    );
  }
}
