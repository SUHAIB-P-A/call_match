import 'package:flutter/material.dart';

class AttentAndEndCall extends StatelessWidget {
  const AttentAndEndCall({
    super.key,
    required this.height,
    required this.width,
    required this.onAccept,
  });

  final double height;
  final double width;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //ACCEPT
        GestureDetector(
          onTap: onAccept,
          child: Container(
            height: height - 720,
            width: width - 320,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://image.pngaaa.com/338/619338-middle.png"),
              ),
            ),
          ),
        ),
        //END CALL
        GestureDetector(
          onTap: () {
            
          },
          child: Container(
            height: height - 720,
            width: width - 320,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://cdn2.iconfinder.com/data/icons/weby-flat-vol-2/512/weby-flat_call_end-call_drop-512.png"),
              ),
            ),
          ),
        )
      ],
    );
  }
}