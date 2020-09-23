import 'package:directus_flutter/src/api/api_filter.dart';

enum RequestMethod {GET, POST, PATCH, DELETE}

class ApiRequest {
  String host, path;
  dynamic data;
  Map<String, String> headers;
  Map<String, String> query;
  RequestMethod method;

  ApiRequest(this.host, this.path, {this.data, this.headers, this.query, this.method = RequestMethod.GET}) {
    this.headers = this.headers ?? {};
    this.query = this.query ?? {};
  }

  ApiRequest addFilter(List<ApiFilter> filter) {
    if(filter != null) {
      List<MapEntry<String, String>> filterEntries;
      filterEntries = filter.map((e) => e.getMapEntry()).toList(growable: false);
      query.addEntries(filterEntries);
    }
    return this;
  }

  ApiRequest setAccessToken(String accessToken) {
    query['access_token'] ??= accessToken;
    return this;
  }

  Uri getUri() {
    return Uri.https(host, path, query);
  }
}