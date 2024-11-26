import 'config_map.dart';
import 'downward_api.dart';
import 'service_account_token.dart';
import 'source.dart';

class Projected {
  late List<Source> sources;
  int? defaultMode;

  Projected.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('sources')) {
      sources = [];
      for (Map<String, dynamic> e in data['sources']) {
        final key = e.keys.first;
        final value = e.values.first;
        switch (key) {
          case ('serviceAccountToken'):
            sources.add(ServiceAccountToken.fromMap(value));
          case ('configMap'):
            sources.add(ConfigMap.fromMap(value));
          case ('downwardAPI'):
            sources.add(DownwardAPI.fromMap(value));
        }
      }
    }
  }
}
