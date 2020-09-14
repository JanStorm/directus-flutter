import 'dart:convert';

import 'package:directus_flutter/src/api/abstract_api.dart';
import 'package:directus_flutter/src/api/api_request.dart';
import 'package:http/http.dart' as http;

class DirectusApi implements AbstractDirectusApi {
  static const ROUTE_AUTH = '/auth/authenticate';
  static const ROUTE_COLLECTIONS = '/collections';
  static const ROUTE_ITEMS = '/items/:collection';

  final String project, baseUrl;
  final Map authCredentials;
  String accessToken;

  DirectusApi(this.baseUrl, this.project, {this.authCredentials});

  Future<ApiRequest> addAuthToken(ApiRequest request) async {
    if(accessToken == null) {
      await authenticate(authCredentials);
    }
    request.query['access_token'] ??= accessToken;
    return request;
  }

  String prependProject(String path) {
    return '/' + project + path;
  }

  @override
  Future<bool> authenticate(Map credentials) async {
    ApiRequest request = new ApiRequest(baseUrl, prependProject(ROUTE_AUTH));
    request.data = authCredentials ?? credentials;
    http.Response response = await _POST(request);
    try {
      accessToken = jsonDecode(response.body)['data']['token'];
      return true;
    } catch(e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<Map> getCollection(int id) async {
    ApiRequest request = new ApiRequest(baseUrl, prependProject(ROUTE_COLLECTIONS));
    request = await addAuthToken(request);
    http.Response response = await _GET(request);

  }

  @override
  Future<List> getCollections() async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    ApiRequest request = new ApiRequest(baseUrl, prependProject(ROUTE_COLLECTIONS));
    request = await addAuthToken(request);
    String responseBody = (await _GET(request)).body;
    return await jsonDecode(responseBody)['data'];
  }

  @override
  Future<Map> getItem(String collection, int id) async {
    // TODO: implement getItem
    throw UnimplementedError();
  }

  @override
  Future<List> getItems(String collection) async {
    if(accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }
    String path = prependProject(ROUTE_ITEMS.replaceAll(':collection', collection));
    ApiRequest request = new ApiRequest(baseUrl, path);
    request = await addAuthToken(request);
    String responseBody = (await _GET(request)).body;
    return await jsonDecode(responseBody)['data'];
  }

  Future<http.Response> _GET(ApiRequest request) {
    return http.get(request.getUri(), headers: request.headers);
  }

  Future<http.Response> _POST(ApiRequest request) {
    return http.post(request.getUri(), headers: request.headers, body: request.data);
  }
}