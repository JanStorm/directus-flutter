import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemsScreen extends StatelessWidget {

  final Map collection;
  final DirectusApiConfig _apiConfig;

  const ListItemsScreen(this._apiConfig, this.collection, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Directus Demo Collection Items ")),
      // body coming soon
    );
  }

}