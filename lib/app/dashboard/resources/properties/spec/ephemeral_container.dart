import 'env_from_source.dart';
import 'env_var.dart';
import 'lifecycle.dart';
import 'probe.dart';

class EphemeralContainer {
  late List<String> args;
  late List<String> command;
  late List<EnvVar> env;
  late List<EnvFromSource> envFrom;
  late String image;
  late String imagePullPolicy;
  late Lifecycle lifecycle;
  late Probe livenessProbe;
  late String name;

  EphemeralContainer.fromMap(Map<String, dynamic> data) {
    args = data['args'] as List<String>;
    command = data['command'] as List<String>;
    env = (data['env'] as List<Map<String, dynamic>>)
        .map(
          (e) => EnvVar.fromMap(e),
        )
        .toList();
    envFrom = (data['envFrom'] as List<Map<String, dynamic>>)
        .map(
          (e) => EnvFromSource.fromMap(e),
        )
        .toList();
    image = data['image'];
    imagePullPolicy = data['imagePullPolicy'];
    lifecycle = Lifecycle.fromMap(data['lifecycle']);
    livenessProbe = Probe.fromMap(data['livenessProbe']);
    name = data['name'];
  }
}
