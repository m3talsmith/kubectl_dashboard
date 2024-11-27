import 'http_header.dart';

class HTTPGetAction {
  late String host;
  late List<HTTPHeader> httpHeaders;
  late String path;
  late dynamic port;
  late String scheme;

  HTTPGetAction.fromMap(Map<String, dynamic> data) {
    host = data['host'];
    httpHeaders = (data['httpHeaders'] as List<Map<String, dynamic>>)
        .map(
          (e) => HTTPHeader.fromMap(e),
        )
        .toList();
    path = data['path'];
    port = data['port'];
    scheme = data['scheme'];
  }
}
