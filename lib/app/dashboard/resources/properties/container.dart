import 'env.dart';
import 'port.dart';
import 'probe.dart';
import 'security_context.dart';
import 'volume_mount.dart';

class Container {
  late String name;
  late String image;
  late List<String> args;
  late List<Port> ports;
  late List<Env> env;
  late Map<String, dynamic> resources;
  late List<VolumeMount> volumeMounts;
  late String terminationMessagePath;
  late String terminationMessagePolicy;
  late String imagePullPolicy;
  late SecurityContext securityContext;

  // deployments
  Probe? livelinessProbe;
  Probe? readinessProbe;
  late List<String> command;

  Container.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    image = data['image'];
    args = [];
    if (data.containsKey('args')) {
      for (String e in data['args']) {
        args.add(e);
      }
    }

    ports = [];
    if (data.containsKey('ports')) {
      for (Map<String, dynamic> e in data['ports']) {
        ports.add(Port.fromMap(e));
      }
    }

    env = [];
    if (data.containsKey('env')) {
      for (Map<String, dynamic> e in data['env']) {
        env.add(Env.fromMap(e));
      }
    }

    resources = {};
    if (data.containsKey('resources')) {
      (data['resources'] as Map<String, dynamic>)
          .forEach((key, value) => resources[key] = value);
    }

    volumeMounts = [];
    if (data.containsKey('volumeMounts')) {
      for (Map<String, dynamic> e in data['volumeMounts']) {
        volumeMounts.add(VolumeMount.fromMap(e));
      }
    }

    terminationMessagePath = data['terminationMessagePath'];
    terminationMessagePolicy = data['terminationMessagePolicy'];
    imagePullPolicy = data['imagePullPolicy'];
    if (data.containsKey('securityContext')) {
      securityContext = SecurityContext.fromMap(data['securityContext']);
    }

    if (data.containsKey('livelinessProbe')) {
      livelinessProbe = Probe.fromMap(data['livelinessProbe']);
    }

    if (data.containsKey('readinessProbe')) {
      readinessProbe = Probe.fromMap(data['readinessProbe']);
    }

    command = [];
    if (data.containsKey('command')) {
      for (String e in data['command']) {
        command.add(e);
      }
    }
  }
}
