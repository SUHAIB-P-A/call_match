import 'package:call_match/presentation/main_home_pages/screens/store/widget/scaech_menu.dart';
import 'package:call_match/presentation/main_home_pages/widgets/profile_add_coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaymentScreenUI extends StatelessWidget {
  const PaymentScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffdce0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SearchAndMenu(),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileUI(),
            ],
          ),
          Container(
            height: 452,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                const Text(
                  'Cards, UPI & More',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                      {
                        'imgpath': 'assets/images/AI_Image6.png',
                        'name': 'PhonePe'
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String imgpath;
  final String title;
  final String? description;
  final List<Map<String, String>>? subOptions;
  final Widget? child;

  const PaymentOption({
    super.key,
    required this.imgpath,
    required this.title,
    this.description,
    this.subOptions,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
              top: BorderSide(color: Colors.grey, width: 0.5),
              //bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imgpath),
                ),
              ),
            ),
            title: Text(title),
            subtitle: child,
          ),
        ),
        if (subOptions != null)
          Wrap(
            alignment: WrapAlignment.start,
            children: subOptions!
                .map((option) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(option["imgpath"] ?? ""),
                              ),
                            ),
                          ),
                          Text(option['name'] ?? ""),
                        ],
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
