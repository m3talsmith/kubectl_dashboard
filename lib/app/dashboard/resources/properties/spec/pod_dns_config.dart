import 'pod_dns_config_option.dart';

class PodDNSConfig {
  late List<String> nameservers;
  late List<PodDNSConfigOption> options;
  late List<String> searches;

  PodDNSConfig.fromMap(Map<String, dynamic> data) {
    nameservers = data['nameservers'] as List<String>;
    options = (data['options'] as List<Map<String, dynamic>>)
        .map(
          (e) => PodDNSConfigOption.fromMap(e),
        )
        .toList();
    searches = data['searches'] as List<String>;
  }
}
