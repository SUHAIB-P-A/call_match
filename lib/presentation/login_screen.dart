import 'package:call_match/presentation/main_home_pages/main_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "login-screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/images/iPhone 14 & 15 Pro Max - 1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SizedBox.expand(),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 30.0, right: 20.0),
                  child: RichText(
                    text: const TextSpan(
                      text: "Login to meet ",
                      style: TextStyle(
                        fontFamily: "Poppins-light",
                        fontSize: 38,
                        color: Colors.black, // Maintain text color
                      ),
                      children: [
                        TextSpan(
                          text: "your ",
                          style: TextStyle(
                            fontFamily: "Poppins-light",
                            fontSize: 38,
                            color: Colors.black, // Maintain text color
                          ),
                        ),
                        TextSpan(
                          text: "partner!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '  Enter your mobile number',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            255,
                            126,
                            122,
                            122,
                          ), // Maintain text color
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Material(
                        elevation: 5,
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "0000000000",
                            hintStyle: const TextStyle(
                              letterSpacing: 10,
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ), // Adjust padding
                            border: InputBorder.none, // Remove border
                            filled: true,
                            fillColor: Colors.grey[
                                300], // Optional: Background color for the text field
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ), // Round corners
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ), // Round corners
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              10), // Adjust spacing between TextField and button
                      SizedBox(
                        width: double.infinity, // Make button full width
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFFD93755,
                            ), // background color
                            foregroundColor: const Color(
                              0xFFFFFFFF,
                            ), // foreground color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Round button edges
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 25.0), // Button padding
                          ),
                          onPressed: () {
                            // Add functionality for the button here
                            Navigator.of(context)
                                .pushReplacementNamed(MainHome.routeName);
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height:
                              0), // Adjust spacing between Button and "--or--" text
                      const Center(
                        child: Text(
                          '⎯⎯⎯⎯  or ⎯⎯⎯⎯',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Color.fromARGB(255, 101, 99, 99), // Text color
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/images/search.png',
                              width: 120.0,
                              height: 120.0,
                            ),
                            onPressed: () {
                              // Add functionality for the search icon button here
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/images/fb.png',
                              width: 120.0,
                              height: 120.0,
                            ),
                            onPressed: () {
                              // Add functionality for the fb icon button here
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'By Signing up, you agree to ',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 11),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'our Terms',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle the tap on "our Terms"
                                  },
                              ),
                              const TextSpan(
                                text: '. See how we use your data in our ',
                              ),
                              TextSpan(
                                text: 'privacy policy.',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle the tap on "privacy policy"
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
