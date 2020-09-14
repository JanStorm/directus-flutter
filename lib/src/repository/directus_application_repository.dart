import 'package:directus_flutter/src/api/api.dart';

class DirectusApplicationRepository {

  static const BASE_URL = 'demo.directus.io';
  static const PROJECT = 'thumper';

  static const AUTH_CREDENTIALS = {
    'email': 'admin@example.com',
    'password': 'password'
  };

  static Future<List> getCollections() async {
    DirectusApi api = new DirectusApi(BASE_URL, PROJECT);
    await api.authenticate(AUTH_CREDENTIALS);
    return await api.getCollections();
  }
}