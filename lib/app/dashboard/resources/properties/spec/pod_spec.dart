import 'affinity.dart';
import 'container.dart';
import 'ephemeral_container.dart';
import 'pod_dns_config.dart';

class PodSpec {
  int? activeDeadlineSeconds;
  late Affinity affinity;
  late bool automountServiceAccountToken;
  late List<Container> containers;
  late PodDNSConfig dnsConfig;
  late String dnsPolicy;
  late bool enableServiceLinks;
  late List<EphemeralContainer> ephemeralContainers;

  PodSpec.fromMap(Map<String, dynamic> data) {
    activeDeadlineSeconds = data['activeDeadlineSeconds'];
    affinity = data['affinity'];
    automountServiceAccountToken = data['automountServiceAccountToken'];
  }
}
