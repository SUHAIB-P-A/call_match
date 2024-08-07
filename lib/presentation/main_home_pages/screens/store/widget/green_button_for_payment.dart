// import 'package:call_match/data/agentlist/data.dart';
// import 'package:call_match/data/call_package/call_package.dart';
// import 'package:call_match/data/chatpack_age/chatpack_age.dart';
// import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class GreenButtonForPayment extends StatelessWidget {
//   GreenButtonForPayment({
//     super.key,
//     required this.coinPriceNotifier,
//     required this.showPaymentScreenNotifier,
//     required this.height,
//     required this.width,
//   });

//   final ValueNotifier<String> coinPriceNotifier;
//   final ValueNotifier<bool> showPaymentScreenNotifier;
//   final double height;
//   final double width;
//   final ValueNotifier<List<ChatpackAge>> _chatpackNotifier = ValueNotifier([]);
//   final ValueNotifier<List<CallPackage>> _callpackNotifier = ValueNotifier([]);
//   final Razorpay razorpay = Razorpay();
//   @override
//   Widget build(BuildContext context) {
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     WidgetsBinding.instance.addPostFrameCallback(
//       (timeStamp) async {
//         //await player2.setSource(AssetSource("assets/audio/Outgoing.mp3"));
//         final chatpacklist = await ApiCallFunctions.instance.chatpackage();
//         _chatpackNotifier.value = chatpacklist.toList();
//         final callpacklist = await ApiCallFunctions.instance.callpackage();
//         _callpackNotifier.value = callpacklist.toList();
//       },
//     );
//     return DefaultTabController(
//       length: 2,
//       child: Container(
//         height: height - 480,
//         width: width - 65,
//         decoration: BoxDecoration(
//           color: Colors.transparent.withOpacity(0.30),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             const TabBar(
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white,
//               tabs: [
//                 Tab(
//                   text: "Call Pack",
//                 ),
//                 Tab(
//                   text: "Chat Pack",
//                 )
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   _buildCallPackView(),
//                   _buildChatPackView(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCallPackView() {
//     return ValueListenableBuilder(
//       valueListenable: _callpackNotifier,
//       builder: (
//         context,
//         callpackages,
//         _,
//       ) {
//         if (callpackages.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           itemCount: callpackages.length,
//           itemBuilder: (context, index) {
//             final callpack = callpackages[index];
//             final packagePrice = callpack.packagePrice ?? "";
//             final totalCoins = callpack.totalCoins ?? "";
//             return ListTile(
//               leading: const CircleAvatar(
//                 radius: 15,
//                 backgroundImage: AssetImage(
//                     "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
//               ),
//               title: Text(
//                 "$totalCoins Coins",
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//               trailing: Container(
//                 height: 25,
//                 width: 105,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xff59982B),
//                       Color(0xff99DD43),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     var options = {
//                       'key': 'rzp_test_aC9DPAWjju4j9Q',
//                       'amount': 100,
//                       'name': 'call match.',
//                       'description': '',
//                       'prefill': {
//                         'contact': '8888888888',
//                         'email': 'test@razorpay.com'
//                       }
//                     };
//                     razorpay.open(options);
//                     // coinPriceNotifier.value = "$packagePrice";
//                     // showPaymentScreenNotifier.value = true;
//                     // PaymentScreenUI.packageId = callpack.coinId;
//                     // PaymentScreenUI.package = "call";
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     minimumSize: const Size(
//                       100,
//                       25,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                         11,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Rs $packagePrice",
//                     style: const TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildChatPackView() {
//     return ValueListenableBuilder(
//       valueListenable: _chatpackNotifier,
//       builder: (
//         context,
//         chatpack,
//         _,
//       ) {
//         if (chatpack.isEmpty) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           itemCount: chatpack.length,
//           itemBuilder: (context, index) {
//             final chatpacks = chatpack[index];
//             final messagecount = chatpacks.messageCount ?? "";
//             final price = chatpacks.packagePrice ?? "";

//             return ListTile(
//               leading: const CircleAvatar(
//                 radius: 15,
//                 backgroundImage: AssetImage(
//                     "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
//               ),
//               title: Text(
//                 "$messagecount Coins",
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                 ),
//               ),
//               trailing: Container(
//                 height: 25,
//                 width: 105,
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xff59982B),
//                       Color(0xff99DD43),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(11),
//                 ),
//                 child: ElevatedButton(
//                   onPressed: () {
//                      var options = {
//                        'key': 'rzp_test_aC9DPAWjju4j9Q',
//                        'amount': 100,
//                        'name': 'call match.',
//                        'description': '',
//                        'prefill': {
//                          'contact': '8888888888',
//                          'email': 'test@razorpay.com'
//                        }

//                      };
//                      razorpay.open(options);
//                     // coinPriceNotifier.value = "$price";
//                     // showPaymentScreenNotifier.value = true;
//                     // PaymentScreenUI.packageId = chatpacks.chatId;
//                     // PaymentScreenUI.package = "chat";
//                     // Pass the packageId
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.transparent,
//                     minimumSize: const Size(
//                       100,
//                       25,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(
//                         11,
//                       ),
//                     ),
//                   ),
//                   child: Text(
//                     "Rs $price",
//                     style: const TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//   }
// }

import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/call_package/call_package.dart';
import 'package:call_match/data/call_purchase/call_purchase.dart';
import 'package:call_match/data/chat_purchase/chat_purchase.dart';
import 'package:call_match/data/chatpack_age/chatpack_age.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/presentation/main_home_pages/screens/store/payment_gateway/payment.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GreenButtonForPayment extends StatefulWidget {
  GreenButtonForPayment({
    Key? key,
    required this.coinPriceNotifier,
    required this.showPaymentScreenNotifier,
    required this.height,
    required this.width,
  }) : super(key: key);

  final ValueNotifier<String> coinPriceNotifier;
  final ValueNotifier<bool> showPaymentScreenNotifier;
  final double height;
  final double width;

  @override
  _GreenButtonForPaymentState createState() => _GreenButtonForPaymentState();
}

class _GreenButtonForPaymentState extends State<GreenButtonForPayment> {
  final ValueNotifier<List<ChatpackAge>> _chatpackNotifier = ValueNotifier([]);
  final ValueNotifier<List<CallPackage>> _callpackNotifier = ValueNotifier([]);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  final Razorpay _razorpay = Razorpay();

  bool isseleted = false;
  
  int? chatids;
  int? callids;

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _fetchPackages();
  }

  @override
  void dispose() {
    _razorpay.clear();
    _chatpackNotifier.dispose();
    _callpackNotifier.dispose();
    super.dispose();
  }

  Future<void> _fetchPackages() async {
    final chatpacklist = await ApiCallFunctions.instance.chatpackage();
    _chatpackNotifier.value = chatpacklist.toList();
    final callpacklist = await ApiCallFunctions.instance.callpackage();
    _callpackNotifier.value = callpacklist.toList();
  }

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
    return DefaultTabController(
      length: 2,
      child: Container(
        height: widget.height - 480,
        width: widget.width - 65,
        decoration: BoxDecoration(
          color: Colors.transparent.withOpacity(0.30),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [Tab(text: "Call Pack"), Tab(text: "Chat Pack")],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildCallPackView(),
                  _buildChatPackView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallPackView() {
    return ValueListenableBuilder(
      valueListenable: _callpackNotifier,
      builder: (context, List<CallPackage> callpackages, _) {
        if (callpackages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: callpackages.length,
          itemBuilder: (context, index) {
            final callpack = callpackages[index];
            final int packagePrice = callpack.packagePrice ?? 0;
            final totalCoins = callpack.totalCoins ?? "";
            return ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
              ),
              title: Text(
                "$totalCoins Coins",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Container(
                height: 25,
                width: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff59982B),
                      Color(0xff99DD43),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    isseleted =true;
                    final callid = callpack.coinId;
                    callids = callid;
                    //isseletedcall = true;
                    var options = {
                      'key': 'rzp_live_LtqaZhUYh7bgOH',
                      'amount': 0.1,
                      //packagePrice*   100, // Convert to paise
                      'name': 'call match.',
                      'description': '',
                      'prefill': {
                        'contact': '8888888888',
                        'email': 'test@razorpay.com'
                      }
                    };
                    _razorpay.open(options);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(100, 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    "Rs $packagePrice",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildChatPackView() {
    return ValueListenableBuilder(
      valueListenable: _chatpackNotifier,
      builder: (context, List<ChatpackAge> chatpacks, _) {
        if (chatpacks.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: chatpacks.length,
          itemBuilder: (context, index) {
            final chatpack = chatpacks[index];
            final messageCount = chatpack.messageCount ?? "";
            final int price = chatpack.packagePrice ?? 0;

            return ListTile(
              leading: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(
                    "assets/images/Gold_Coin_Transparent_PNG_Clipart7.png"),
              ),
              title: Text(
                "$messageCount Coins",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Container(
                height: 25,
                width: 105,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff59982B),
                      Color(0xff99DD43),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: ElevatedButton(
                  onPressed: () async{
                    
                    final idchat = chatpack.chatId;
                    chatids = idchat;
                    isseleted = false;
                     var options = {
                       'key': 'rzp_live_LtqaZhUYh7bgOH',
                       'amount': 0.1,
                       //price* 100,  Convert to paise
                       'name': 'call match.',
                       'description': '',
                       'prefill': {
                         'contact': '8888888888',
                         'email': 'test@razorpay.com'
                       }
                     };
                     _razorpay.open(options);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(100, 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: Text(
                    "Rs $price",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String? paymentid = response.paymentId;
    // Show the payment ID in a dialog box
    //_showPaymentIdDialog(paymentid!);

    if (isseleted == true) {
      final modelcall = CallPurchase.create(
          userId: "${logindetailslistcalling.value!.customerId}",
          packageId: "$callids",
          razorpayPaymentId: paymentid);

      await ApiCallFunctions.instance.callPurchase(modelcall);
    } else {
      final modelchat = ChatPurchase.create(
          userId: "${logindetailslistcalling.value!.customerId}",
          packageId: "$chatids",
          razorpayPaymentId: paymentid);

      await ApiCallFunctions.instance.chatPurchase(modelchat);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction Successful!')),
    );
    // Add further actions based on the success response
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction Failed!')),
    );
    // Add further actions based on the error response
  }

  
}
