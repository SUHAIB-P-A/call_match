import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

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
      receiverUpiId: "",
      receiverName: 'CALL MATCH',
      transactionRefId: 'TXN123456',
      transactionNote: 'Payment for order TXN123456',
      amount: 1.00, // Replace with the amount you want to transact
    );

    if (transaction.status == UpiPaymentStatus.SUCCESS) {
      // Payment was successful
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
