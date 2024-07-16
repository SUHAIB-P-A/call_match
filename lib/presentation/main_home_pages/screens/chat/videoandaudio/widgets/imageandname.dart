import 'package:flutter/material.dart';
import 'dart:async';

class ImageAndNameUI extends StatelessWidget {
  ImageAndNameUI({
    super.key,
    required this.height,
    required this.width,
    required this.name,
    required this.calltype,
    this.callAcceptedNotifier,
  });

  final double height;
  final double width;
  final String name;
  final String calltype;
  final ValueNotifier<int> timerNotifier = ValueNotifier<int>(0);
  final ValueNotifier<bool>? callAcceptedNotifier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height - 550,
          width: width - 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  "https://static.vecteezy.com/system/resources/previews/009/380/423/original/man-face-clipart-design-illustration-free-png.png"),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: callAcceptedNotifier!,
          builder: (
            context,
            accepted,
            _,
          ) {
            if (accepted == true) {
              startTimer();
              return ValueListenableBuilder(
                valueListenable: timerNotifier,
                builder: (
                  context,
                  timerValue,
                  _,
                ) {
                  final minutes = (timerValue ~/ 60).toString().padLeft(2, '0');
                  final seconds = (timerValue % 60).toString().padLeft(2, '0');
                  return Text(
                    '$minutes:$seconds',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: "Poppins-Light",
                    ),
                  );
                },
              );
            } else {
              return Text(
                calltype,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins-Light",
                ),
              );
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 40,
            fontFamily: "Poppins-Regular",
          ),
        ),
      ],
    );
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (callAcceptedNotifier!.value == true) {
        timerNotifier.value += 1;
      } else {
        print(timerNotifier.value.toString());
        timer.cancel();
      }
    });
  }
}
