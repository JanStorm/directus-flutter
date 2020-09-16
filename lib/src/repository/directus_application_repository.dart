import 'package:directus_flutter/src/api/api.dart';
import 'package:directus_flutter/src/api/api_config.dart';

class DirectusApplicationRepository {

  static Future<List> getCollections(DirectusApiConfig config) async {
    DirectusApi api = new DirectusApi(config.host, config.project);
    await api.authenticate(config.getAuthCredentials());
    return await api.getCollections();
  }

  static Future<List> getItems(DirectusApiConfig config, String collection) async {
    DirectusApi api = new DirectusApi(config.host, config.project);
    await api.authenticate(config.getAuthCredentials());
    return await api.getItems(collection);
  }

  static Future<Map> getItem(DirectusApiConfig config, String collection, int id) async {
    DirectusApi api = new DirectusApi(config.host, config.project);
    await api.authenticate(config.getAuthCredentials());
    return await api.getItem(collection, id);
  }
}