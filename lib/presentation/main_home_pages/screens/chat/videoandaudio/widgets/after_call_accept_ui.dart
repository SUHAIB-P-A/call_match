import 'package:flutter/material.dart';

class AfterAcceptCall extends StatelessWidget {
  const AfterAcceptCall({
    super.key,
    this.callAccepted,
    required this.onEnd,
    required this.onToggleLoudspeaker,
    required this.onToggleMute,
    required this.isLoudspeakerOn,
    required this.isMuted,
  });

  final ValueNotifier<bool>? callAccepted;
  final VoidCallback onEnd;
  final VoidCallback onToggleLoudspeaker;
  final VoidCallback onToggleMute;
  final ValueNotifier<bool> isLoudspeakerOn;
  final ValueNotifier<bool> isMuted;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callAccepted!.value = true;
      },
      child: Container(
        height: 70,
        width: 255,
        decoration: BoxDecoration(
          color: const Color(0xffffdce0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onToggleLoudspeaker,
              child: ValueListenableBuilder<bool>(
                valueListenable: isLoudspeakerOn,
                builder: (context, isOn, child) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(
                      color: isOn ? Colors.green : Colors.grey,
                      Icons.speaker_phone,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: onToggleMute,
              child: ValueListenableBuilder<bool>(
                valueListenable: isMuted,
                builder: (context, isMuted, child) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(
                      color: isMuted ? Colors.red : Colors.grey,
                      Icons.mic_off,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            //call end button
            InkWell(
              onTap: () {
                onEnd();
                callAccepted!.value = false;
              },
              child: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://cdn2.iconfinder.com/data/icons/weby-flat-vol-2/512/weby-flat_call_end-call_drop-512.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
