// Import the test package and Counter class
import 'package:directus_flutter/directus_flutter.dart';
import 'package:directus_flutter/src/api/api_config.dart';
import 'package:flutter_test/flutter_test.dart';

const demoApiConfig = DirectusApiConfig(
    'demo.directus.io',
    'thumper',
    'admin@example.com',
    'password'
);

void main() {
  test('Get all collections', () async {
    List data = await DirectusApplicationRepository.getCollections(demoApiConfig);
    expect(data.length > 0, true);
  });
}