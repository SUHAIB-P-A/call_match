import 'package:call_match/presentation/agent_ui/main_home.dart';
import 'package:call_match/presentation/home_screen.dart';
import 'package:call_match/presentation/login_screen.dart';
import 'package:call_match/presentation/main_home_pages/main_home.dart';
//import 'package:call_match/presentation/main_home_pages/screens/chat/videoandaudio/audio_outgoing.dart';

final routers = {
  HomeScreen.routename: (ctx) => const HomeScreen(),
  LoginScreen.routeName: (ctx) => LoginScreen(),
  MainHome.routeName: (ctx) => MainHome(),
  MainHomeAgent.routeName: (ctx) => MainHomeAgent()
  //AudioOutgoingUI.routeName:(ctx) => const AudioOutgoingUI(contactname: ""),
  //PaymentScreenUI.routename: (ctx) => const PaymentScreenUI(coinpriceone: PaymentScreenUI.routename,),
};
