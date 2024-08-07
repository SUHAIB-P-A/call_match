import 'dart:developer';

import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/presentation/agent_ui/main_home.dart';
import 'package:call_match/presentation/home_screen.dart';
import 'package:call_match/presentation/main_home_pages/main_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);

  Future<bool> checkPreferenceValue(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
          try {
        // Get the shared preferences instance
        final prefs = await SharedPreferences.getInstance();
        log('SharedPreferences instance obtained.');

        // Retrieve the phone number from shared preferences
        String? phoneUserNumber = prefs.getString("phone_number");
        log('Retrieved phone number: $phoneUserNumber');

        // If phone number is null or invalid, handle accordingly
        if (phoneUserNumber == null || phoneUserNumber.isEmpty) {
          log('Invalid phone number: $phoneUserNumber');
          // Handle the invalid phone number case, e.g., notify the user or set a default value
          phoneUserNumber = "0000000000"; // or handle appropriately
        }

        // Call the checkuser function with the retrieved phone number
        final loginUserDetail = await ApiCallFunctions.instance
            .checkuser(phoneUserNumber.toString());
        log('checkuser function called. User details: $loginUserDetail');

        // Assign the returned user details to a value notifier
        logindetailslistcalling.value = loginUserDetail;
        log('User details assigned to value notifier.');
      } catch (e) {
        log('Error in someFunction: $e');
      }
    }
    );
    //delay fuction
    Future.delayed(const Duration(seconds: 3), () async {
      bool valueExists = await checkPreferenceValue('phone_number');
      if (valueExists && logindetailslistcalling.value != null) {
        if (logindetailslistcalling.value!.isExisting == false &&
            logindetailslistcalling.value!.status == "Agent User") {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
        } else if (logindetailslistcalling.value!.status == "Agent User") {
          Navigator.of(context).pushReplacementNamed(MainHomeAgent.routeName);
        } else if (logindetailslistcalling.value!.status == "Normal User") {
          Navigator.of(context).pushReplacementNamed(MainHome.routeName);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      }
    });

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xffb42c44)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Stack(
                children: [
                  Positioned(
                    bottom: 25,
                    left: 75,
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/git_splash.gif",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    "Call Match",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70,
                      fontFamily: "Anokha",
                    ),
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
