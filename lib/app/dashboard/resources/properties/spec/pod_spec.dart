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
  }
}
