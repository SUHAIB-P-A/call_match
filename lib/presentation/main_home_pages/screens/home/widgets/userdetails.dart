import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/presentation/agent_ui/main_home.dart';
import 'package:call_match/presentation/home_screen.dart';
import 'package:call_match/presentation/main_home_pages/main_home.dart';
import 'package:call_match/presentation/main_home_pages/screens/home/widgets/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsPage extends StatelessWidget {
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);

  UserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final phoneno = await SharedPreferences.getInstance();
        final phoneusernumber = phoneno.getString("phone_number");
        if (phoneusernumber != null) {
          final loginuserdetail =
              await ApiCallFunctions.instance.loginWithNumber(phoneusernumber);
          logindetailslistcalling.value = loginuserdetail;
        }
      },
    );

    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        if (logindetailslistcalling.value!.status == "Agent User") {
          Navigator.of(context).pushReplacementNamed(MainHomeAgent.routeName);
        } else if (logindetailslistcalling.value!.status == "Normal User") {
          Navigator.of(context).pushReplacementNamed(MainHome.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                if (logindetailslistcalling.value!.status == "Agent User") {
                  Navigator.of(context)
                      .pushReplacementNamed(MainHomeAgent.routeName);
                } else if (logindetailslistcalling.value!.status ==
                    "Normal User") {
                  Navigator.of(context)
                      .pushReplacementNamed(MainHome.routeName);
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          backgroundColor: const Color(0xFFD93755),
          title: const Text('User Details'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder<LoginedUser?>(
            valueListenable: logindetailslistcalling,
            builder: (context, user, child) {
              return Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailRow(
                            label: 'First Name:',
                            value: user?.customerFirstName ?? 'N/A',
                          ),
                          DetailRow(
                            label: 'Last Name:',
                            value: user?.customerLastName ?? 'N/A',
                          ),
                          DetailRow(
                            label: 'Email:',
                            value: user?.customerEmail ?? 'N/A',
                          ),
                          DetailRow(
                            label: 'Contact:',
                            value: user?.customerContact ?? 'N/A',
                          ),
                          DetailRow(
                            label: 'Languages:',
                            value: user?.languages ?? 'N/A',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.routename);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD93755),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
