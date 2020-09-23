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

  Uri getUri() {
    return Uri.https(host, path, query);
  }
}