import 'package:flutter/material.dart';

class AfterAcceptCall extends StatelessWidget {
  const AfterAcceptCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 255,
      decoration: BoxDecoration(
        color: const Color(0xffffdce0),
        borderRadius: BorderRadius.circular(30),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            child: Icon(
              color: Colors.grey,
              Icons.speaker_phone,
            ),
          ),
          const SizedBox(width: 10,),
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            child: Icon(
              color: Colors.grey,
              Icons.mic_external_off
            ),
          ),
          const SizedBox(width: 10,),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  "https://cdn2.iconfinder.com/data/icons/weby-flat-vol-2/512/weby-flat_call_end-call_drop-512.png"),
            ),
          ),
        ],
      ),
    );
  }
}
