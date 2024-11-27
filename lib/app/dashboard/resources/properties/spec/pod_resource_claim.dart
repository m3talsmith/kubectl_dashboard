import 'claim_source.dart';

class PodResourceClaim {
  late String name;
  late ClaimSource source;

  PodResourceClaim.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    source = ClaimSource.fromMap(data['source']);
  }
}
