import 'package:flutter/material.dart';

class ListViewUI extends StatelessWidget {
  const ListViewUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          height: 450,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  title: const Text(
                    "Name",
                    style: TextStyle(fontFamily: "Poppins-Regular"),
                  ),
                  subtitle: const Text(
                    "Mumbai",
                    style: TextStyle(fontFamily: "Poppins-Regular"),
                  ),
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/736x/7a/57/08/7a5708d3347e1965a6df017fdb960965.jpg"),
                    radius: 23,
                  ),
                  trailing: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      image: DecorationImage(
                        alignment: Alignment.center,
                        scale: 0.5,
                        image: AssetImage("assets/images/love_symbol.png"),
                      ),
                    ),
                  ));
            },
            itemCount: 20,
          )),
    );
  }
}
