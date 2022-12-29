import 'package:example/src/screen/list_collections.dart';
import 'package:flutter/material.dart';
import 'package:directus_flutter/directus_flutter.dart';

const demoApiConfig = DirectusApiConfig(
    '192.168.2.30:8055',
    'Directus',
    'admin@example.com',
    'password'
);


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Directus Widget Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListCollectionsScreen(demoApiConfig),
    );
  }
}

