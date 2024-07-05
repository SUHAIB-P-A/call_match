import 'package:flutter/material.dart';

class PaymentSome extends StatelessWidget {
  const PaymentSome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cards, UPI & More',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PaymentOption(
              icon: Icons.credit_card,
              title: 'Card',
              description: '',
            ),
            PaymentOption(
              icon: Icons.phone_android,
              title: 'UPI',
              description: 'Pay with installed app, or use others',
              subOptions: ['Google Pay', 'PhonePe', 'Paytm', 'Others'],
            ),
            PaymentOption(
              icon: Icons.account_balance,
              title: 'Netbanking',
              description: 'All Indian banks',
            ),
            PaymentOption(
              icon: Icons.account_balance_wallet,
              title: 'Wallet',
              description: 'Paytm and Freecharge',
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹6000',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Pay Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<String>? subOptions;

  PaymentOption({
    required this.icon,
    required this.title,
    required this.description,
    this.subOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(description),
            onTap: () {},
          ),
        ),
        if (subOptions != null)
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subOptions!
                  .map((option) => ListTile(
                        title: Text(option),
                        onTap: () {},
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
