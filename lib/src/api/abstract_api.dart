abstract class AbstractDirectusApi {
  Future<bool> authenticate(Map credentials);

  Future<List> getCollections();
  Future<Map> getCollection(int id);

  Future<List> getItems(String collection);
  Future<Map> getItem(String collection, int id);

}