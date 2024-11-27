import 'container_port.dart';
import 'container_resize_policy.dart';
import 'env_from_source.dart';
import 'env_var.dart';
import 'lifecycle.dart';
import 'probe.dart';
import 'resource_requirements.dart';

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
}
