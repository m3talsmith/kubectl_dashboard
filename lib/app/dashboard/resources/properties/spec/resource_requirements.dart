import 'resource_claim.dart';

class ResourceRequirements {
  late List<ResourceClaim> claims;
  late Map<String, dynamic> limits;
  late Map<String, dynamic> requests;

  ResourceRequirements.fromMap(Map<String, dynamic> data) {
    claims = (data['claims'] as List<Map<String, dynamic>>)
        .map(
          (e) => ResourceClaim.fromMap(e),
        )
        .toList();
    limits = {};
    for (var e in (data['limits'] as Map<String, dynamic>).entries) {
      limits[e.key] = e.value;
    }
    requests = {};
    for (var e in (data['requests'] as Map<String, dynamic>).entries) {
      requests[e.key] = e.value;
    }
  }
}
