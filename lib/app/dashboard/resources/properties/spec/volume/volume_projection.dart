import 'projection/config_map_projection.dart';
import 'projection/downward_api_projection.dart';
import 'projection/secret_projection.dart';
import 'projection/service_account_token_projection.dart';

class VolumeProjection {
  late ConfigMapProjection configMap;
  late DownwardAPIProjection downwardAPI;
  late SecretProjection secret;
  late ServiceAccountTokenProjection serviceAccountToken;

  VolumeProjection.fromMap(Map<String, dynamic> data) {
    configMap = ConfigMapProjection.fromMap(data['configMap']);
    downwardAPI = DownwardAPIProjection.fromMap(data['downwardAPI']);
    secret = SecretProjection.fromMap(data['secret']);
    serviceAccountToken =
        ServiceAccountTokenProjection.fromMap(data['serviceAccountToken']);
  }
}
