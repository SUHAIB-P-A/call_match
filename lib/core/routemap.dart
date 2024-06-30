import 'package:call_match/presentation/home_screen.dart';
import 'package:call_match/presentation/login_screen.dart';

final routers = {
  HomeScreen.routename: (ctx) => const HomeScreen(),
  LoginScreen.routeName: (ctx) => const LoginScreen(),
};
