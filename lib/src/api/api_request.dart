class ApiRequest {
  String baseUrl, path;
  dynamic data;
  Map<String, String> headers;
  Map<String, String> query;

  ApiRequest(this.baseUrl, this.path, {this.data, this.headers, this.query}) {
    this.headers = this.headers ?? {};
    this.query = this.query ?? {};
  }

  Uri getUri() {
    return Uri.https(baseUrl, path, query);
  }
}