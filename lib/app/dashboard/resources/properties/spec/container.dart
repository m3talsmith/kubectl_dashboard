import 'container_port.dart';
import 'container_resize_policy.dart';
import 'env_from_source.dart';
import 'env_var.dart';
import 'lifecycle.dart';
import 'probe.dart';
import 'resource_requirements.dart';
import 'security_context.dart';
import 'volume_device.dart';
import 'volume_mount.dart';

// https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/#container-v1-core
class Container {
  late List<String> args;
  late List<String> command;
  late List<EnvVar> env;
  late List<EnvFromSource> envFrom;
  late String image;
  late String imagePullPolicy;
  late Lifecycle lifecycle;
  late Probe livenessProbe;
  late String name;
  late List<ContainerPort> ports;
  late Probe readinessProbe;
  late List<ContainerResizePolicy> resizePolicy;
  late ResourceRequirements resources;
  late String restartPolicy;
  late SecurityContext securityContext;
  late Probe startupProbe;
  late bool stdin;
  late bool stdinOnce;
  late String terminationMessagePath;
  late String terminationMessagePolicy;
  late bool tty;
  late List<VolumeDevice> volumeDevices;
  late List<VolumeMount> volumeMounts;
  late String workingDir;

  Container.fromMap(Map<String, dynamic> data) {
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
    ports = (data['ports'] as List<Map<String, dynamic>>)
        .map(
          (e) => ContainerPort.fromMap(e),
        )
        .toList();
    readinessProbe = Probe.fromMap(data['readinessProbe']);
    resizePolicy = (data['resizePolicy'] as List<Map<String, dynamic>>)
        .map(
          (e) => ContainerResizePolicy.fromMap(e),
        )
        .toList();
    resources = ResourceRequirements.fromMap(data['resources']);
    restartPolicy = data['restartPolicy'];
    securityContext = SecurityContext.fromMap(data['securityContext']);
    startupProbe = Probe.fromMap(data['startupProbe']);
    stdin = data['stdin'];
    stdinOnce = data['stdinOnce'];
    terminationMessagePath = data['terminationMessagePath'];
    terminationMessagePolicy = data['terminationMessagePolicy'];
    tty = data['tty'];
    volumeDevices = (data['volumeDevices'] as List<Map<String, dynamic>>)
        .map(
          (e) => VolumeDevice.fromMap(e),
        )
        .toList();
    volumeMounts = (data['volumeMounts'] as List<Map<String, dynamic>>)
        .map(
          (e) => VolumeMount.fromMap(e),
        )
        .toList();
    workingDir = data['workingDir'];
  }
}
