import 'package:flutter/material.dart';

class CallState {
  static final ValueNotifier<bool> callEndedNotifier =
      ValueNotifier<bool>(false);

  static void endCall() {
    debugPrint("CallState: endCall() called");
    callEndedNotifier.value = true;
  }

  static void resetCall() {
    debugPrint("CallState: resetCall() called");
    callEndedNotifier.value = false;
  }
}
