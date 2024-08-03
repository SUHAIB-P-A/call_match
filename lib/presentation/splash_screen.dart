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
    //delay fuction
    Future.delayed(const Duration(seconds: 3), () {
      if (logindetailslistcalling.value!.isExisting == true &&
          logindetailslistcalling.value!.status == "Agent User") {
        Navigator.of(context).pushReplacementNamed(MainHomeAgent.routeName);
      } else if (logindetailslistcalling.value!.isExisting == true &&
          logindetailslistcalling.value!.status == "Normal User") {
        Navigator.of(context).pushReplacementNamed(MainHome.routeName);
      }

      if (logindetailslistcalling.value!.isExisting == false &&
          logindetailslistcalling.value!.status == "Agent User") {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      }

      Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
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
