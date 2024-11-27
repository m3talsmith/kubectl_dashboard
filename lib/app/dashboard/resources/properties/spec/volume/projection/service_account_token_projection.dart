class ServiceAccountTokenProjection {
  late String audience;
  late int expirationSeconds;
  late String path;

  ServiceAccountTokenProjection.fromMap(Map<String, dynamic> data) {
    audience = data['audience'];
    expirationSeconds = data['expirationSeconds'];
    path = data['path'];
  }
}
