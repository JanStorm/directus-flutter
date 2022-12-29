import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowItemScreen extends StatelessWidget {

  final Map collection, item;
  final DirectusApiConfig _apiConfig;

  const ShowItemScreen(this._apiConfig, this.collection, this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Item')),
      body: SingleChildScrollView(
          child: FutureBuilder(
              future: DirectusApplicationRepository.getItem(_apiConfig, collection['collection'], item['id']),
              builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.error, color: Colors.red),
                      Text(
                          "Ein Fehler bei der API-Abfrage ist aufgetreten: " +
                              snapshot.error.toString())
                    ],
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> data = snapshot.data!;
                Map fields = collection['fields'] ?? {};
                List<Widget> children = [];
                print(collection.toString());
                data.forEach((key, value) {
                  if (fields[key]?['meta']?['hidden'] != true) {
                    children.addAll([DirectusWidget(fields[key], value, key: ValueKey(key))]);
                  }
                });
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: children,
                );
              }))
      );
  }

}