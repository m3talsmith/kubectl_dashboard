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
  List<String>? args;
  List<String>? command;
  List<EnvVar>? env;
  List<EnvFromSource>? envFrom;
  String? image;
  String? imagePullPolicy;
  Lifecycle? lifecycle;
  Probe? livenessProbe;
  String? name;
  List<ContainerPort>? ports;
  Probe? readinessProbe;
  List<ContainerResizePolicy>? resizePolicy;
  ResourceRequirements? resources;
  String? restartPolicy;
  SecurityContext? securityContext;
  Probe? startupProbe;
  bool? stdin;
  bool? stdinOnce;
  String? terminationMessagePath;
  String? terminationMessagePolicy;
  bool? tty;
  List<VolumeDevice>? volumeDevices;
  List<VolumeMount>? volumeMounts;
  String? workingDir;

  Container.fromMap(Map<String, dynamic> data) {
    if (data['args'] != null) {
      args = [];
      for (var e in data['args']) {
        args!.add(e);
      }
    }
    if (data['command'] != null) {
      command = [];
      for (var e in data['command']) {
        command!.add(e);
      }
    }
    if (data['env'] != null) {
      env = [];
      for (var e in data['env']) {
        env!.add(EnvVar.fromMap(e));
      }
    }
    if (data['envFrom'] != null) {
      envFrom = [];
      for (var e in data['envFrom']) {
        envFrom!.add(EnvFromSource.fromMap(e));
      }
    }
    image = data['image'];
    imagePullPolicy = data['imagePullPolicy'];
    if (data['lifecycle'] != null) {
      lifecycle = Lifecycle.fromMap(data['lifecycle']);
    }
    if (data['livenessProbe'] != null) {
      livenessProbe = Probe.fromMap(data['livenessProbe']);
    }
    name = data['name'];
    if (data['ports'] != null) {
      ports = [];
      for (var e in data['ports']) {
        ports!.add(ContainerPort.fromMap(e));
      }
    }
    if (data['readinessProbe'] != null) {
      readinessProbe = Probe.fromMap(data['readinessProbe']);
    }
    if (data['resizePolicy'] != null) {
      resizePolicy = [];
      for (var e in data['resizePolicy']) {
        resizePolicy!.add(ContainerResizePolicy.fromMap(e));
      }
    }
    if (data['resources'] != null) {
      resources = ResourceRequirements.fromMap(data['resources']);
    }
    restartPolicy = data['restartPolicy'];
    if (data['securityContext'] != null) {
      securityContext = SecurityContext.fromMap(data['securityContext']);
    }
    if (data['startupProbe'] != null) {
      startupProbe = Probe.fromMap(data['startupProbe']);
    }
    stdin = data['stdin'];
    stdinOnce = data['stdinOnce'];
    terminationMessagePath = data['terminationMessagePath'];
    terminationMessagePolicy = data['terminationMessagePolicy'];
    tty = data['tty'];
    if (data['volumeDevices'] != null) {
      volumeDevices = [];
      for (var e in data['volumeDevices']) {
        volumeDevices!.add(VolumeDevice.fromMap(e));
      }
    }
    if (data['volumeMounts'] != null) {
      volumeMounts = [];
      for (var e in data['volumeMounts']) {
        volumeMounts!.add(VolumeMount.fromMap(e));
      }
    }
    workingDir = data['workingDir'];
  }
}
