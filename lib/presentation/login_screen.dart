import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "login-screen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0, left: 30.0, right: 20.0),
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
                    style: TextStyle(),
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
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '  Enter your mobile number',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(
                        255, 126, 122, 122), // Maintain text color
                  ),
                ),
                const SizedBox(height: 3),
                Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "0000000000",
                      hintStyle:
                          const TextStyle(letterSpacing: 10, color: Colors.grey),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0), // Adjust padding
                      border: InputBorder.none, // Remove border
                      filled: true,
                      fillColor: Colors.grey[
                          300], // Optional: Background color for the text field
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.circular(20.0), // Round corners
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius:
                            BorderRadius.circular(20.0), // Round corners
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 10), // Adjust spacing between TextField and button
                SizedBox(
                  width: double.infinity, // Make button full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFD93755), // background color
                      foregroundColor:
                          const Color(0xFFFFFFFF), // foreground color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5.0), // Round button edges
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 25.0), // Button padding
                    ),
                    onPressed: () {
                      // Add functionality for the button here
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
                        10), // Adjust spacing between Button and "--or--" text
                const Center(
                  child: Text(
                    '⎯⎯⎯⎯  or ⎯⎯⎯⎯',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 101, 99, 99), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/loginimage.png',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: -40.0, // Adjust the position of the icon buttons
                  right: 200.0, // Adjust the position of the search icon button
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/search.png',
                      width: 120.0,
                      height: 120.0,
                    ),
                    onPressed: () {
                      // Add functionality for the search icon button here
                    },
                  ),
                ),
                Positioned(
                  top: -40.0, // Adjust the position of the icon buttons
                  right: 50.0, // Adjust the position of the fb icon button
                  child: IconButton(
                    icon: Image.asset(
                      'assets/images/fb.png',
                      width: 120.0,
                      height: 120.0,
                    ),
                    onPressed: () {
                      // Add functionality for the fb icon button here
                    },
                  ),
                ),
            
                Positioned(
                  bottom: 250.0, // Adjust the position of the text
                  right: 0, // Align the text to the right
                  left: 15, // Ensure the text spans the full width
                  child: Center(
                    child: Column(
                      
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'By Signing up, you agree to',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 150, 147, 147),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                foregroundColor:
                                    WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 150, 147, 147),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("our Terms"),
                            ),
                            const Text(
                              "see how",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 150, 147, 147),
                              ),
                            ),
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "we use your data in our",
                              style: TextStyle(
                                fontSize: 11,
                                color: Color.fromARGB(255, 150, 147, 147),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                textStyle: WidgetStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                foregroundColor:
                                    WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 150, 147, 147),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text(
                                "privacy policy.",
                              ),
                            ),
                          ],)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
