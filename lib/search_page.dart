import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        TextField(
            decoration: const InputDecoration(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: 'Search',
        ))
      ],
    );
  }
}
