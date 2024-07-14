import 'package:call_match/core/routemap.dart';
import 'package:call_match/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:call_match/core/agora_chat_initializer.dart'; // Import Agora Chat Initializer

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Agora Chat SDK
  //AgoraChatInitializer.initializeAgoraChat().then((_) {
    // Set preferred orientations after initializing Agora Chat
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(const MyApp());
    });
  //}
  //);
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
      home: const SplashScreen(),
      routes: routers,
    );
  }
}
