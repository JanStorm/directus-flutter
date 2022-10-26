// Import the test package and Counter class
import 'package:directus_flutter/directus_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

const demoApiConfig = DirectusApiConfig(
    'demo.directus.io',
    'thumper',
    'admin@example.com',
    'password'
);

void main() {

  Map collection, item;

  test('Get first item in first collection', () async {
    List data = await DirectusApplicationRepository.getCollections(demoApiConfig);
    expect(data.length > 0, true);
    collection = data.first;

    List data1 = await DirectusApplicationRepository.getItems(demoApiConfig, collection['collection']);
    expect(data1.length > 0, true);
    item = data1.first;

    Map data2 = await DirectusApplicationRepository.getItem(demoApiConfig, collection['collection'], item['id']);
    expect(data2.length > 0, true);
  });
}