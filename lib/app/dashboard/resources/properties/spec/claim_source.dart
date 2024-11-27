class ClaimSource {
  late String resourceClaimName;
  late String resourceClaimTemplate;

  ClaimSource.fromMap(Map<String, dynamic> data) {
    resourceClaimName = data['resourceClaimName'];
    resourceClaimTemplate = data['resourceClaimTemplate'];
  }
}
