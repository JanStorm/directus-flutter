// Import the test package and Counter class
import 'package:directus_flutter/src/repository/directus_application_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get all collections', () async {
    List data = await DirectusApplicationRepository.getCollections();
    expect(data.length > 0, true);
  });
}