import 'dart:io';

import 'package:directus_flutter/src/api/api_filter.dart';

enum RequestMethod { GET, POST, PATCH, DELETE }

class ApiRequest {
  String host, path;
  dynamic data;
  late Map<String, String> headers;
  late Map<String, String> query;
  RequestMethod method;

  ApiRequest(this.host, this.path,
      {this.data, Map<String, String>? headers, Map<String, String>? query, this.method = RequestMethod.GET}) {
    this.headers = headers ?? {};
    this.query = query ?? {};

    if(this.headers[HttpHeaders.contentTypeHeader] == null) {
      this.headers[HttpHeaders.contentTypeHeader] = 'application/json';
    }
  }

  ApiRequest addFilter(List<ApiFilter>? filter) {
    if (filter != null) {
      List<MapEntry<String, String>> filterEntries;
      filterEntries = filter.map((e) => e.getMapEntry()).toList();
      query.addEntries(filterEntries);
    }
    return this;
  }

  ApiRequest setAccessToken(String? accessToken) {
    if (accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
    }
    return this;
  }

  ApiRequest setDepth(int depth) {
    if(depth > 0) {
      String fields = '*';
      for(var i = 0; i < depth; i++) {
        fields += '.*';
      }
      query.addAll({
        'fields': fields,
      });
    }
    return this;
  }

  Uri getUri() {
    return Uri.http(host, path, query);
  }
}
