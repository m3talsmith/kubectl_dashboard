class ServiceAccountTokenProjection {
  String? audience;
  int? expirationSeconds;
  String? path;

  ServiceAccountTokenProjection.fromMap(Map<String, dynamic> data) {
    audience = data['audience'];
    expirationSeconds = data['expirationSeconds'];
    path = data['path'];
  }
}
