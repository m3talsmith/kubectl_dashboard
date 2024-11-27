import 'projection/config_map_projection.dart';
import 'projection/downward_api_projection.dart';
import 'projection/secret_projection.dart';
import 'projection/service_account_token_projection.dart';

class VolumeProjection {
  ConfigMapProjection? configMap;
  DownwardAPIProjection? downwardAPI;
  SecretProjection? secret;
  ServiceAccountTokenProjection? serviceAccountToken;

  VolumeProjection.fromMap(Map<String, dynamic> data) {
    if (data['configMap'] != null) {
      configMap = ConfigMapProjection.fromMap(data['configMap']);
    }
    if (data['downwardAPI'] != null) {
      downwardAPI = DownwardAPIProjection.fromMap(data['downwardAPI']);
    }
    if (data['secret'] != null) {
      secret = SecretProjection.fromMap(data['secret']);
    }
    if (data['serviceAccountToken'] != null) {
      serviceAccountToken =
          ServiceAccountTokenProjection.fromMap(data['serviceAccountToken']);
    }
  }
}
