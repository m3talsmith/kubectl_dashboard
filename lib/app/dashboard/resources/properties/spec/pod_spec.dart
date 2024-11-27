import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/spec.dart';

import 'affinity.dart';
import 'container.dart';
import 'ephemeral_container.dart';
import 'host_alias.dart';
import 'local_object_reference.dart';
import 'pod_dns_config.dart';
import 'pod_os.dart';
import 'pod_readiness_gate.dart';
import 'pod_resource_claim.dart';
import 'pod_scheduling_gate.dart';
import 'pod_security_context.dart';
import 'toleration.dart';
import 'topology_spread_constraint.dart';
import 'volume.dart';

class PodSpec extends Spec {
  int? activeDeadlineSeconds;
  Affinity? affinity;
  bool? automountServiceAccountToken;
  List<Container>? containers;
  PodDNSConfig? dnsConfig;
  String? dnsPolicy;
  bool? enableServiceLinks;
  List<EphemeralContainer>? ephemeralContainers;
  List<HostAlias>? hostAliases;
  bool? hostIPC;
  bool? hostNetwork;
  bool? hostUsers;
  String? hostname;
  List<LocalObjectReference>? imagePullSecrets;
  List<Container>? initContainers;
  String? nodeName;
  Map<String, dynamic>? nodeSelector;
  PodOS? os;
  Map<String, dynamic>? overhead;
  String? preemptionPolicy;
  int? priority;
  String? priorityClassName;
  List<PodReadinessGate>? readinessGates;
  List<PodResourceClaim>? resourceClaims;
  String? resourcePolicy;
  String? runtimeClassName;
  String? schedulerName;
  List<PodSchedulingGate>? schedulingGates;
  PodSecurityContext? securityContext;
  String? serviceAccount;
  String? serviceAccountName;
  bool? setHostnameAsFQDN;
  bool? shareProcessNamespace;
  String? subdomain;
  int? terminationGracePeriodSeconds;
  List<Toleration>? tolerations;
  List<TopologySpreadConstraint>? topologySpreadConstraints;
  List<Volume>? volumes;

  PodSpec.fromMap(Map<String, dynamic> data) {
    activeDeadlineSeconds = data['activeDeadlineSeconds'];
    if (data['affinity'] != null) affinity = Affinity.fromMap(data['affinity']);
    automountServiceAccountToken = data['automountServiceAccountToken'];
    if (data['containers'] != null) {
      containers = [];
      for (var e in data['containers']) {
        containers!.add(Container.fromMap(e));
      }
    }
    if (data['dnsConfig'] != null) {
      dnsConfig = PodDNSConfig.fromMap(data['dnsConfig']);
    }
    dnsPolicy = data['dnsPolicy'];
    enableServiceLinks = data['enableServiceLinks'];
    if (data['ephemeralContainers'] != null) {
      ephemeralContainers = [];
      for (var e in data['ephemeralContainers']) {
        ephemeralContainers!.add(EphemeralContainer.fromMap(e));
      }
    }
    if (data['hostAliases'] != null) {
      hostAliases = [];
      for (var e in data['hostAliases']) {
        hostAliases!.add(HostAlias.fromMap(e));
      }
    }
    hostIPC = data['hostIPC'];
    hostNetwork = data['hostNetwork'];
    hostUsers = data['hostUsers'];
    hostname = data['hostname'];
    if (data['imagePullSecrets'] != null) {
      imagePullSecrets = [];
      for (var e in data['imagePullSecrets']) {
        imagePullSecrets!.add(LocalObjectReference.fromMap(e));
      }
    }
    if (data['initContainers'] != null) {
      initContainers = [];
      for (var e in data['initContainers']) {
        initContainers!.add(Container.fromMap(e));
      }
    }
    nodeName = data['nodeName'];
    if (data['nodeSelector'] != null) {
      nodeSelector = {};
      for (var e in (data['nodeSelector'] as Map<String, dynamic>).entries) {
        nodeSelector![e.key] = e.value;
      }
    }
    if (data['os'] != null) {
      os = PodOS.fromMap(data['os']);
    }
    if (data['overhead'] != null) {
      overhead = {};
      for (var e in (data['overhead'] as Map<String, dynamic>).entries) {
        overhead![e.key] = e.value;
      }
    }
    preemptionPolicy = data['preemptionPolicy'];
    priority = data['priority'];
    priorityClassName = data['priorityClassName'];
    if (data['readinessGates'] != null) {
      readinessGates = [];
      for (var e in data['readinessGates']) {
        readinessGates!.add(PodReadinessGate.fromMap(e));
      }
    }
    if (data['resourceClaims'] != null) {
      resourceClaims = [];
      for (var e in data['resourceClaims']) {
        resourceClaims!.add(PodResourceClaim.fromMap(e));
      }
    }
    resourcePolicy = data['resourcePolicy'];
    runtimeClassName = data['runtimeClassName'];
    schedulerName = data['schedulerName'];
    if (data['schedulingGates'] != null) {
      schedulingGates = [];
      for (var e in data['schedulingGates']) {
        schedulingGates!.add(PodSchedulingGate.fromMap(e));
      }
    }
    if (data['securityContext'] != null) {
      securityContext = PodSecurityContext.fromMap(data['securityContext']);
    }
    serviceAccount = data['serviceAccount'];
    serviceAccountName = data['serviceAccountName'];
    setHostnameAsFQDN = data['setHostnameAsFQDN'];
    shareProcessNamespace = data['shareProcessNamespace'];
    subdomain = data['subdomain'];
    terminationGracePeriodSeconds = data['terminationGracePeriodSeconds'];
    if (data['tolerations'] != null) {
      tolerations = [];
      for (var e in data['tolerations']) {
        tolerations!.add(Toleration.fromMap(e));
      }
    }
    if (data['topologySpreadConstraints'] != null) {
      topologySpreadConstraints = [];
      for (var e in data['topologySpreadConstraints']) {
        topologySpreadConstraints!.add(TopologySpreadConstraint.fromMap(e));
      }
    }
    if (data['volumes'] != null) {
      volumes = [];
      for (var e in data['volumes']) {
        volumes!.add(Volume.fromMap(e));
      }
    }
  }
}
