import 'package:flutter/material.dart';

class ImageAndNameUI extends StatelessWidget {
  const ImageAndNameUI({
    super.key,
    required this.height,
    required this.width,
    required this.name,
    required this.calltype,
  });

  final double height;
  final double width;
  final String name;
  final String calltype;

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
         Text(
          calltype,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: "Poppins-Light",
          ),
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
}
