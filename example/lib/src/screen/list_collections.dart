import 'package:example/src/screen/list_items.dart';
import 'package:flutter/material.dart';
import 'package:directus_flutter/directus_flutter.dart';

class ListCollectionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Directus Demo Collections')),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: DirectusApplicationRepository.getCollections(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    Text("Ein Fehler bei der API-Abfrage ist aufgetreten: "+snapshot.error.toString())
                  ],
                );
              }
              List collections = snapshot.data;
              List<Widget> children = collections.map((data) => ListTile(
                title: Text(data['collection'] ?? 'Keine Bezeichnung'),
                subtitle: Text(data['note'] ?? ''),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListItemsScreen()),
                  );
                },
              )).toList(growable: false);
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: children,
              );
            }
        ),
      ),
    );
  }
}