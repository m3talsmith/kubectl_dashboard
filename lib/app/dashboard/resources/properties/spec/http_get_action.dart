import 'http_header.dart';

class HTTPGetAction {
  String? host;
  List<HTTPHeader>? httpHeaders;
  String? path;
  dynamic port;
  String? scheme;

  HTTPGetAction.fromMap(Map<String, dynamic> data) {
    host = data['host'];
    if (data['httpHeaders'] != null) {
      httpHeaders = [];
      for (var e in data['httpHeaders']) {
        httpHeaders!.add(HTTPHeader.fromMap(e));
      }
    }
    path = data['path'];
    port = data['port'];
    scheme = data['scheme'];
  }
}
