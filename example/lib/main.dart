import 'package:directus_flutter/directus_flutter_core.dart';
import 'package:example/src/example_data/textarea.dart';
import 'file:///E:/htdocs/Flutter/plugins/directus_flutter_core/example/example/lib/src/abstract_example.dart';
import 'package:example/src/example_data/wysiwyg.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  List<AbstractExample> examples = [
    TextareaExample(),
    WYSIWYGExample(),
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map<String, Map> _exampleData = {};

  @override
  void initState() {
    getAllExampleData();
    super.initState();
  }

  void getAllExampleData() async {
    for(int i = 0; i < widget.examples.length; i++) {
      AbstractExample example = widget.examples.elementAt(i);
      Map data = await example.getData();
      setState(() {
        _exampleData.addAll({example.runtimeType.toString(): data});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directus Widget Demo')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: _exampleData.keys.map((title) => Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title+':', style: TextStyle(fontSize: 16)),
              ),
              DirectusWidget(_exampleData[title])
            ],
          )).toList(growable: false),
        ),
      ),
    );
  }
}

