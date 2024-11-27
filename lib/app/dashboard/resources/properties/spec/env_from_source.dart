import 'config_map_env_source.dart';
import 'secret_env_source.dart';

class EnvFromSource {
  late ConfigMapEnvSource configMapRef;
  late String prefix;
  late SecretEnvSource secretRef;

  EnvFromSource.fromMap(Map<String, dynamic> data) {
    configMapRef = ConfigMapEnvSource.fromMap(data['configMapRef']);
    prefix = data['prefix'];
    secretRef = SecretEnvSource.fromMap(data['secretRef']);
  }
}
