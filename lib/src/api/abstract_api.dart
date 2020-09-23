import 'package:directus_flutter/src/api/api_request.dart';
import 'package:http/http.dart';

abstract class AbstractDirectusApi {
  Future<bool> authenticate(Map credentials);

  Future<List> getCollections();
  Future<Map> getCollection(int id);

  Future<List> getItems(String collection);
  Future<Map> getItem(String collection, int id);

  Future<Response> processRequest(ApiRequest request);
}