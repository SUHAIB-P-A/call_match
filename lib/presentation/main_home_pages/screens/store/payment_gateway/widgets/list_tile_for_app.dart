import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String imgpath;
  final String title;
  final String? description;
  final List<Map<String, String>>? subOptions;
  final Widget? child;

  const PaymentOption({
    super.key,
    required this.imgpath,
    required this.title,
    this.description,
    this.subOptions,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.grey, width: 0.5),
              right: BorderSide(color: Colors.grey, width: 0.5),
              top: BorderSide(color: Colors.grey, width: 0.5),
              //bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: ListTile(
            isThreeLine: true,
            leading: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imgpath),
                ),
              ),
            ),
            title: Text(title),
            subtitle: child,
          ),
        ),
        if (subOptions != null)
          Wrap(
            alignment: WrapAlignment.start,
            children: subOptions!
                .map((option) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(option["imgpath"] ?? ""),
                              ),
                            ),
                          ),
                          Text(option['name'] ?? ""),
                        ],
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}
