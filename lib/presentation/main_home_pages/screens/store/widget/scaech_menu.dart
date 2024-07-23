import 'package:call_match/data/agentlist/data.dart';
import 'package:flutter/material.dart';

class SearchAndMenu extends StatelessWidget {
  const SearchAndMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //search icon
        IconButton(
          onPressed: () {
            ApiCallFunctions.instance.getAgentModelList();
          },
          icon: const Icon(
            Icons.search,
            color: Color(0xFFD93755),
          ),
        ),
        //menu icon
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Color(0xFFD93755),
          ),
        ),
      ],
    );
  }
}
