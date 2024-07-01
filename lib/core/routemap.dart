import 'package:call_match/presentation/home_screen.dart';
import 'package:call_match/presentation/login_screen.dart';
import 'package:call_match/presentation/main_home_pages/main_home.dart';

final routers = {
  HomeScreen.routename: (ctx) => const HomeScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
  MainHome.routeName: (ctx) =>  MainHome(),
};
