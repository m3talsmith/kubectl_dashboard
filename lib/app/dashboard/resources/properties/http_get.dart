class HttpGet {
  String? path;
  dynamic port;
  String? scheme;

  HttpGet.fromMap(Map<String, dynamic> data) {
    path = data['path'];
    port = data['port'];
    scheme = data['scheme'];
  }
}
