import 'dart:convert';
import 'dart:io';

import 'package:directus_flutter/src/api/abstract_api.dart';
import 'package:directus_flutter/src/api/api_filter.dart';
import 'package:directus_flutter/src/api/api_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DirectusApi implements AbstractDirectusApi {
  static const ROUTE_AUTH = '/auth/login';
  static const ROUTE_COLLECTIONS = '/collections';
  static const ROUTE_ALL_FIELDS = '/fields';
  static const ROUTE_COLLECTION_FIELDS = ROUTE_ALL_FIELDS + '/:collection';
  static const ROUTE_ITEMS = '/items/:collection';
  static const ROUTE_ITEM = '/items/:collection/:id';
  static const ROUTE_USERS_ME = '/users/me';

  final String project, host;
  final Map? authCredentials;
  String? accessToken;

  DirectusApi(this.host, this.project, {this.authCredentials});

  Future<String?> getAuthToken() async {
    if (accessToken == null && authCredentials != null) {
      await authenticate(authCredentials!);
    }
    return accessToken;
  }

  String prependProject(String path) {
    return '/' + project + path;
  }

  @override
  Future<bool> authenticate(Map credentials) async {
    ApiRequest request = new ApiRequest(
      host,
      ROUTE_AUTH,
      method: RequestMethod.POST,
    );
    request.data = jsonEncode(authCredentials ?? credentials);
    http.Response response = await processRequest(request);
    try {
      accessToken = jsonDecode(response.body)['data']['access_token'];
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  @override
  Future<Map> getCurrentUser() async {
    await getAuthToken();
    if (accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    ApiRequest request = new ApiRequest(
      host,
      ROUTE_USERS_ME,
      method: RequestMethod.GET,
    );
    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    return jsonDecode(response.body);
  }

  @override
  Future<Map> getCollection(int id) async {
    await getAuthToken();

    ApiRequest request = new ApiRequest(
      host,
      ROUTE_COLLECTIONS,
      method: RequestMethod.GET,
    );
    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    return jsonDecode(response.body);
  }

  Future<List> getFields([String? collection]) async {
    await getAuthToken();
    if (accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    String route = ROUTE_ALL_FIELDS;
    if (collection != null) {
      route = ROUTE_COLLECTION_FIELDS.replaceAll(':collection', collection);
    }

    ApiRequest request = new ApiRequest(
      host,
      route,
      method: RequestMethod.GET,
    );

    request.setAccessToken(accessToken);
    http.Response response = await processRequest(request);
    return jsonDecode(response.body)['data'] ?? [];
  }

  @override
  Future<List> getCollections({List<ApiFilter>? filter}) async {
    await getAuthToken();
    if (accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    ApiRequest request = new ApiRequest(
      host,
      ROUTE_COLLECTIONS,
      method: RequestMethod.GET,
    );
    request.setAccessToken(accessToken);
    request.addFilter(filter);
    String responseBody = (await processRequest(request)).body;
    List collections = await jsonDecode(responseBody)['data'] ?? [];
    List fields = await getFields();
    for (Map collection in collections) {
      collection['fields'] = {};
      for (Map field in fields.where((field) => field['collection'] == collection['collection']).toList()) {
        collection['fields'][field['field']] = field;
      }
    }
    return collections;
  }

  @override
  Future<Map<String, dynamic>> getItem(String collection, int id, {int depth = 3}) async {
    await getAuthToken();
    if (accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }

    String path = ROUTE_ITEM
          .replaceAll(':collection', collection)
          .replaceAll(':id', id.toString(),
    );
    ApiRequest request = new ApiRequest(host, path, method: RequestMethod.GET);
    request.setAccessToken(accessToken);
    request.setDepth(depth);
    String responseBody = (await processRequest(request)).body;
    return await jsonDecode(responseBody)['data'] ?? {} ;
  }

  @override
  Future<List> getItems(String collection, {List<ApiFilter>? filter, int depth = 3}) async {
    if (accessToken == null) {
      throw new Exception('You have to be authorized to use this method!');
    }
    await getAuthToken();

    String path = ROUTE_ITEMS.replaceAll(':collection', collection);
    ApiRequest request = new ApiRequest(host, path, method: RequestMethod.GET);
    request.addFilter(filter);
    request.setAccessToken(accessToken);
    request.setDepth(depth);
    http.Response response = await processRequest(request);
    String responseBody = response.body;
    dynamic data = await jsonDecode(responseBody)['data'] ?? [];
    if (data is Map) {
      debugPrint('WARN: Directus API returned a map instead of a list when getting items!');
      data = data.values.toList();
    }
    return data;
  }

  @override
  Future<http.Response> processRequest(ApiRequest request) async {
    // Enable this line if you want so log all network traffic to directus
    // debugPrint("[NETWORKING] ${request.method} ${request.getUri()}");
    http.Response response;
    switch (request.method) {
      case RequestMethod.GET:
        response = await http.get(
          request.getUri(),
          headers: request.headers,
        );
        break;
      case RequestMethod.POST:
        response = await http.post(
          request.getUri(),
          headers: request.headers,
          body: request.data,
        );
        break;
      case RequestMethod.PATCH:
        response = await http.patch(
          request.getUri(),
          headers: request.headers,
          body: request.data,
        );
        break;
      case RequestMethod.DELETE:
        response = await http.delete(
          request.getUri(),
          headers: request.headers,
        );
        break;
      default:
        throw Exception("This Request Methods are currently not supported");
        break;
    }

    // Pre-process response data
    if(response.headers[HttpHeaders.contentTypeHeader] == 'application/json') {
      Map body = jsonDecode(response.body);
      for(Map msg in body['messages'] ?? []) {
        String text = '[directus_flutter]';
        if(msg['type'] != null) text    += '[${msg['type'].toString().toUpperCase()}] ';
        if(msg['code'] != null) text    += 'Code ${msg['code'].toString()} ';
        if(msg['fields'] != null) text  += 'for fields ${msg['fields'].toString()}';
        if(msg['message'] != null) text += ': ${msg['message']}. ';
        text += '- Request was ${request.method} ${request.getUri()}';
        print(text);
      }

      if (body['errors'] != null) {
        throw new Exception(body['errors']);
      }
    }

    // TODO error check / handling
    return response;
  }
}
