import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemsScreen extends StatelessWidget {

  final Map collection;

  const ListItemsScreen({Key key, this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Directus Demo Collection Items ")),
      // body coming soon
    );
  }

}