import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/wallet_details/wallet_details.dart';
import 'package:flutter/material.dart';

class AddCoinDisplayUI extends StatelessWidget {
  AddCoinDisplayUI({
    super.key,
  });
  final ValueNotifier<List<WalletDetails>> walletnotifier = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final wallet = await ApiCallFunctions.instance.getWalletDetails();
        

        print(wallet.toList());
        walletnotifier.value = wallet;
      },
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              const Color(0xffD02D4E),
            ),
          ),
          onPressed: () {},
          child: Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"))),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "ADD COIN",
                style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: 39,
              decoration: const BoxDecoration(
                color: Color.fromARGB(179, 236, 235, 235),
                borderRadius: BorderRadius.all(
                  Radius.elliptical(20, 20),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            "assets/images/PROTOTYPE CALLMATCH 003-03.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder(
                    valueListenable: walletnotifier,
                    builder: (
                      context,
                      value,
                      _,
                    ) {
                      return Text(
                        '${value[1].walletCoins}',
                        style: TextStyle(
                          fontFamily: "Poppins-Regular",
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
