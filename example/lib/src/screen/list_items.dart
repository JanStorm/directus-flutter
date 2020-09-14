import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemsScreen extends StatelessWidget {
  final Map collection;
  final DirectusApiConfig _apiConfig;

  const ListItemsScreen(this._apiConfig, this.collection, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Directus Demo Collection Items ")),
        body: SingleChildScrollView(
            child: FutureBuilder(
                future:
                    DirectusApplicationRepository.getItems(_apiConfig, collection['collection']),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
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
                  List items = snapshot.data;
                  List<Widget> children = items.map((data) => ListTile(
                    title: Text("ID ${data['id']}"),
                    subtitle: Text(data['note'] ?? ''),
                    onTap: () {
                      //Navigator.push(
                      //  context,
                      //  MaterialPageRoute(builder: (context) => ListItemScreen(_apiConfig, data)),
                      //);
                    },
                  )).toList();
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: children,
                  );
                }))
        // body coming soon
        );
  }
}
