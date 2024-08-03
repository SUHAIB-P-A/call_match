import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/chat_purchase/chat_purchase.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upi_india/upi_india.dart';

class PaymentOption extends StatelessWidget {
  final String imgpath;
  final  package;
  final double? price;
  final String title;
  final String? description;
  final List<Map<String, String>>? subOptions;
  final int? packageId;
  final Widget? child;

  PaymentOption(
      {super.key,
      this.price,
      required this.imgpath,
      required this.title,
      this.description,
      this.subOptions,
      this.child,
      this.package,
      this.packageId});
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final phoneno = await SharedPreferences.getInstance();
        final phoneusernumber = phoneno.getString("phone_number");
        final loginuserdetail = await ApiCallFunctions.instance
            .loginWithNumber(phoneusernumber.toString());
        logindetailslistcalling.value = loginuserdetail;
      },
    );
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
                      child: GestureDetector(
                        onTap: () {
                          _handlePaymentOptionTap(
                              context, option["name"] ?? "");
                        },
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
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }

// UPI APP ACTION FUNCTION
  Future<void> _handlePaymentOptionTap(
      BuildContext context, String optionName) async {
    // Handle the payment request based on the option name
    UpiApp? upiapp;
    UpiIndia upiindia = UpiIndia();
    UpiResponse? transaction;
    if (optionName == 'Google Pay') {
      // Send request to Google Pay
      upiapp = UpiApp.googlePay;
    } else if (optionName == 'PhonePe') {
      // Send request to PhonePe
      upiapp = UpiApp.phonePe;
    } else if (optionName == 'Paytm') {
      // Send request to Paytm
      upiapp = UpiApp.paytm;
    } else if (optionName == 'Others') {
      // Handle other payment options
    }
    // You can add logic to send requests or navigate to specific pages.

    transaction = await upiindia.startTransaction(
      app: upiapp!, // Or use UpiIndiaApp.GooglePay, UpiIndiaApp.PhonePe, etc.
      receiverUpiId: "pt4557996605@okicici",
      receiverName: 'CALL MATCH',
      transactionRefId: 'ksdbchshjcjckhcv225wnxbsd',
      transactionNote: 'Payment for order TXN123456',
      flexibleAmount: true,
      amount: price!, // Replace with the amount you want to transact
    );

    if (transaction.status == UpiPaymentStatus.SUCCESS) {
      // Payment was successful

      if (package == "chat") {
        ChatPurchase.create(
          userId: logindetailslistcalling.value!.customerId.toString(),
          packageId: packageId.toString(),
          razorpayPaymentId: "ksdbchshjcjckhcv225wdk5d",
        );
      } else if (package == "call") {
        ChatPurchase.create(
          userId: logindetailslistcalling.value!.customerId.toString(),
          packageId: packageId.toString(),
          razorpayPaymentId: "ksdbchshjcjckhcv225wnxbsdb",
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction Successful!')),
      );
    } else {
      // Payment failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transaction Failed!')),
      );
    }
  }
}
