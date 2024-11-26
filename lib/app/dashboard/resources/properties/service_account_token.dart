import 'source.dart';

class ServiceAccountToken implements Source {
  late int expirationSeconds;
  late String path;

  ServiceAccountToken.fromMap(Map<String, dynamic> data) {
    expirationSeconds = data['expirationSeconds'];
    path = data['path'];
  }
}
