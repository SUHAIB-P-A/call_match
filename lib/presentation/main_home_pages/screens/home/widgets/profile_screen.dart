import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstnamecontroller = TextEditingController();
    final TextEditingController lastnamecontroller = TextEditingController();
    final TextEditingController emailcontroller = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final phoneno = await SharedPreferences.getInstance();
        final phoneusernumber = phoneno.getString("phone_number");
        final loginuserdetail = await ApiCallFunctions.instance
            .loginWithNumber(phoneusernumber.toString());
        logindetailslistcalling.value = loginuserdetail;
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
        backgroundColor: const Color(0xFFD93755),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              TextField(
                controller: firstnamecontroller,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lastnamecontroller,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Handle save action
                    final String fname = firstnamecontroller.text;
                    final String lname = lastnamecontroller.text;
                    final String email = emailcontroller.text;

                    final updatedUser = LoginedUser.create(
                      customerId: logindetailslistcalling.value?.customerId,
                      customerFirstName: fname,
                      customerLastName: lname,
                      customerEmail: email,
                      customerContact:
                          logindetailslistcalling.value?.customerContact,
                      status: logindetailslistcalling.value?.status,
                      isOnline: logindetailslistcalling.value?.isOnline,
                      languages: logindetailslistcalling.value?.languages,
                      isExisting: logindetailslistcalling.value?.isExisting,
                      adhaarNo: logindetailslistcalling.value?.adhaarNo,
                    );

                    ApiCallFunctions.instance.updateptofile(updatedUser,
                        "${logindetailslistcalling.value!.customerId}");
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD93755),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
