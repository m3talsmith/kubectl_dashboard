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

class PodSpec {
  int? activeDeadlineSeconds;
  late Affinity affinity;
  late bool automountServiceAccountToken;
  late List<Container> containers;
  late PodDNSConfig dnsConfig;
  late String dnsPolicy;
  late bool enableServiceLinks;
  late List<EphemeralContainer> ephemeralContainers;
  late List<HostAlias> hostAliases;
  late bool hostIPC;
  late bool hostNetwork;
  late bool hostUsers;
  late String hostname;
  late List<LocalObjectReference> imagePullSecrets;
  late List<Container> initContainers;
  late String nodeName;
  late Map<String, dynamic> nodeSelector;
  late PodOS os;
  late Map<String, dynamic> overhead;
  late String preemptionPolicy;
  late int priority;
  late String priorityClassName;
  late List<PodReadinessGate> readinessGates;
  late List<PodResourceClaim> resourceClaims;
  late String resourcePolicy;
  late String runtimeClassName;
  late String schedulerName;
  late List<PodSchedulingGate> schedulingGates;
  late PodSecurityContext securityContext;
  late String serviceAccount;
  late String serviceAccountName;
  late bool setHostnameAsFQDN;
  late bool shareProcessNamespace;
  late String subdomain;
  late int terminationGracePeriodSeconds;
  late List<Toleration> tolerations;
  late List<TopologySpreadConstraint> topologySpreadConstraints;
  late List<Volume> volumes;

  PodSpec.fromMap(Map<String, dynamic> data) {
    activeDeadlineSeconds = data['activeDeadlineSeconds'];
    affinity = data['affinity'];
    automountServiceAccountToken = data['automountServiceAccountToken'];
    containers = (data['containers'] as List<Map<String, dynamic>>)
        .map(
          (e) => Container.fromMap(e),
        )
        .toList();
    dnsConfig = PodDNSConfig.fromMap(data['dnsConfig']);
    dnsPolicy = data['dnsPolicy'];
    enableServiceLinks = data['enableServiceLinks'];
    ephemeralContainers =
        (data['ephemeralContainers'] as List<Map<String, dynamic>>)
            .map(
              (e) => EphemeralContainer.fromMap(e),
            )
            .toList();
    hostAliases = (data['hostAliases'] as List<Map<String, dynamic>>)
        .map(
          (e) => HostAlias.fromMap(e),
        )
        .toList();
    hostIPC = data['hostIPC'];
    hostNetwork = data['hostNetwork'];
    hostUsers = data['hostUsers'];
    hostname = data['hostname'];
    imagePullSecrets = (data['imagePullSecrets'] as List<Map<String, dynamic>>)
        .map(
          (e) => LocalObjectReference.fromMap(e),
        )
        .toList();
    initContainers = (data['initContainers'] as List<Map<String, dynamic>>)
        .map(
          (e) => Container.fromMap(e),
        )
        .toList();
    nodeName = data['nodeName'];
    nodeSelector = {};
    for (var e in (data['nodeSelector'] as Map<String, dynamic>).entries) {
      nodeSelector[e.key] = e.value;
    }
    os = PodOS.fromMap(data['os']);
    overhead = {};
    for (var e in (data['overhead'] as Map<String, dynamic>).entries) {
      overhead[e.key] = e.value;
    }
    preemptionPolicy = data['preemptionPolicy'];
    priority = data['priority'];
    priorityClassName = data['priorityClassName'];
    readinessGates = (data['readinessGates'] as List<Map<String, dynamic>>)
        .map(
          (e) => PodReadinessGate.fromMap(e),
        )
        .toList();
    resourceClaims = (data['resourceClaims'] as List<Map<String, dynamic>>)
        .map(
          (e) => PodResourceClaim.fromMap(e),
        )
        .toList();
    resourcePolicy = data['resourcePolicy'];
    runtimeClassName = data['runtimeClassName'];
    schedulerName = data['schedulerName'];
    schedulingGates = (data['schedulingGates'] as List<Map<String, dynamic>>)
        .map(
          (e) => PodSchedulingGate.fromMap(e),
        )
        .toList();
    securityContext = PodSecurityContext.fromMap(data['securityContext']);
    serviceAccount = data['serviceAccount'];
    serviceAccountName = data['serviceAccountName'];
    setHostnameAsFQDN = data['setHostnameAsFQDN'];
    shareProcessNamespace = data['shareProcessNamespace'];
    subdomain = data['subdomain'];
    terminationGracePeriodSeconds = data['terminationGracePeriodSeconds'];
    tolerations = (data['tolerations'] as List<Map<String, dynamic>>)
        .map(
          (e) => Toleration.fromMap(e),
        )
        .toList();
    topologySpreadConstraints =
        (data['topologySpreadConstraints'] as List<Map<String, dynamic>>)
            .map(
              (e) => TopologySpreadConstraint.fromMap(e),
            )
            .toList();
    volumes = (data['volumes'] as List<Map<String, dynamic>>)
        .map(
          (e) => Volume.fromMap(e),
        )
        .toList();
  }
}
