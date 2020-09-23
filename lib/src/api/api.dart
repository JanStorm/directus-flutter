import 'dart:convert';

import 'package:directus_flutter/src/api/abstract_api.dart';
import 'package:directus_flutter/src/api/api_request.dart';
import 'package:http/http.dart' as http;

class DirectusApi implements AbstractDirectusApi {
  static const ROUTE_AUTH = '/auth/authenticate';
  static const ROUTE_COLLECTIONS = '/collections';
  static const ROUTE_ITEMS = '/items/:collection';
  static const ROUTE_ITEM = '/items/:collection/:id';
  static const ROUTE_USERS_ME = '/users/me';

  final String project, host;
  final Map authCredentials;
  String accessToken;

  DirectusApi(this.host, this.project, {this.authCredentials});

  Future<String> getAuthToken() async {
    if(accessToken == null) {
      await authenticate(authCredentials);
    }
    return accessToken;
  }

  String prependProject(String path) {
    return '/' + project + path;
  }

  @override
  Future<bool> authenticate(Map credentials) async {
    ApiRequest request = new ApiRequest(host, prependProject(ROUTE_AUTH), method: RequestMethod.POST);
    request.data = authCredentials ?? credentials;
    http.Response response = await processRequest(request);
    try {
      accessToken = jsonDecode(response.body)['data']['token'];
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<Map> getCurrentUser() async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }
    await getAuthToken();

    ApiRequest request = new ApiRequest(host, prependProject(ROUTE_USERS_ME), method: RequestMethod.GET);
    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    return jsonDecode(response.body);
  }

  @override
  Future<Map> getCollection(int id) async {
    await getAuthToken();

    ApiRequest request = new ApiRequest(host, prependProject(ROUTE_COLLECTIONS), method: RequestMethod.GET);
    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    return jsonDecode(response.body);
  }

  @override
  Future<List> getCollections() async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    ApiRequest request = new ApiRequest(host, prependProject(ROUTE_COLLECTIONS), method: RequestMethod.GET);
    request.setAccessToken(accessToken);
    request.addFilter(filter);
    String responseBody = (await processRequest(request)).body;
    return await jsonDecode(responseBody)['data'];
  }

  @override
  Future<Map> getItem(String collection, int id) async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }
    await getAuthToken();

    String path = prependProject(ROUTE_ITEM
        .replaceAll(':collection', collection)
        .replaceAll(':id', id.toString())
    );
    ApiRequest request = new ApiRequest(host, path, method: RequestMethod.GET);
    request.setAccessToken(accessToken);
    String responseBody = (await processRequest(request)).body;
    return await jsonDecode(responseBody)['data'];
  }

  @override
  Future<List> getItems(String collection) async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }
    await getAuthToken();

    String path = prependProject(ROUTE_ITEMS.replaceAll(':collection', collection));
    ApiRequest request = new ApiRequest(host, path, method: RequestMethod.GET);
    request.addFilter(filter);
    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    String responseBody = response.body;
    return await jsonDecode(responseBody)['data'];
  }

  @override
  Future<http.Response> processRequest(ApiRequest request) async {
    // Enable this line if you want so log all network traffic to directus
    // debugPrint("[NETWORKING] ${request.method} ${request.getUri()}");
    http.Response response;
    switch(request.method) {
      case RequestMethod.GET:
        response = await http.get(request.getUri(), headers: request.headers);
        break;
      case RequestMethod.POST:
        response = await http.post(request.getUri(), headers: request.headers, body: request.data);
        break;
      case RequestMethod.PATCH:
        response = await http.patch(request.getUri(), headers: request.headers, body: request.data);
        break;
      case RequestMethod.DELETE:
        response = await http.delete(request.getUri(), headers: request.headers);
        break;
      default:
        throw Exception("This Request Methods are currently not supported");
        break;
    }

    return response;
  }
}