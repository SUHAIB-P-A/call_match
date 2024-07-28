import 'package:call_match/data/agentlist/data.dart';
import 'package:call_match/data/logined_user/logined_user.dart';
import 'package:call_match/data/model_user_list/model_user_list.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ValueNotifier<File?> _imageNotifier = ValueNotifier<File?>(null);
  final ValueNotifier<LoginedUser?> logindetailslistcalling =
      ValueNotifier(null);
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _imageNotifier.value = File(pickedFile.path);
    }
  }

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
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFD93755),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    ValueListenableBuilder<File?>(
                      valueListenable: _imageNotifier,
                      builder: (context, image, child) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              image != null ? FileImage(image) : null,
                          child: image == null
                              ? const Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.white,
                                )
                              : null,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 2),
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BottomSheet(
                                onClosing: () {},
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.photo_library),
                                      title: const Text('Gallery'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.gallery);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Camera'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.camera);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: firstnamecontroller,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lastnamecontroller,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 30),
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
