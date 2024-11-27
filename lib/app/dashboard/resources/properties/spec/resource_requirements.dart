import 'resource_claim.dart';

class ResourceRequirements {
  List<ResourceClaim>? claims;
  Map<String, dynamic>? limits;
  Map<String, dynamic>? requests;

  ResourceRequirements.fromMap(Map<String, dynamic> data) {
    if (data['claims'] != null) {
      claims = [];
      for (var e in data['claims']) {
        claims!.add(ResourceClaim.fromMap(e));
      }
    }
    if (data['limits'] != null) {
      limits = {};
      for (var e in (data['limits'] as Map<String, dynamic>).entries) {
        limits![e.key] = e.value;
      }
    }
    if (data['requests'] != null) {
      requests = {};
      for (var e in (data['requests'] as Map<String, dynamic>).entries) {
        requests![e.key] = e.value;
      }
    }
  }
}
