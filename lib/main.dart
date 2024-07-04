import 'package:call_match/core/routemap.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PaymentScreenUI(),
      routes: routers,
    );
  }
}
