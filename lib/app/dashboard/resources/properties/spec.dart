import 'container.dart';
import 'load_balancer_service_status.dart';
import 'port.dart';
import 'security_context.dart';
import 'selector.dart';
import 'service_status.dart';
import 'spec/container.dart';
import 'strategy.dart';
import 'template.dart';
import 'toleration.dart';
import 'topology_spread_constraint.dart';
import 'volume.dart';

class Spec {
  Spec();

  // pods
  late List<Volume> volumes;
  late List<Container> containers;
  late String? restartPolicy;
  late int? terminationGracePeriodSeconds;
  late String? dnsPolicy;
  late Map<String, String> nodeSelector;
  late String? serviceAccountName;
  late String? serviceAccount;
  late String? nodeName;
  late SecurityContext? securityContext;
  late String? schedulerName;
  late List<Toleration> tolerations;
  late int? priority;
  late bool? enableServiceLinks;
  late String? preemptionPolicy;

  // services
  late List<Port> ports;
  String? clusterIP;
  late List<String> clusterIPs;
  String? type;
  String? sessionAffinity;
  late List<String> ipFamilies;
  String? ipFamilyPolicy;
  String? internalTrafficPolicy;
  late Map<String, Selector> selector;
  late Map<String, ServiceStatus> status;

  // deployments
  int? replicas;
  late Map<String, Template> template;
  String? priorityClassName;
  late List<TopologySpreadConstraint> topologySpreadConstraints;
  Strategy? strategy;
  int? revisionHistoryLimit;
  int? progressDeadlineSeconds;

  Spec.fromMap(Map<String, dynamic> data) {
    volumes = [];
    if (data.containsKey('volumes')) {
      for (Map<String, dynamic> e in data['volumes']) {
        volumes.add(Volume.fromMap(e));
      }
    }

    containers = [];
    if (data.containsKey('containers')) {
      for (Map<String, dynamic> e in data['containers']) {
        containers.add(Container.fromMap(e));
      }
    }

    restartPolicy = data['restartPolicy'];
    terminationGracePeriodSeconds = data['terminationGracePeriodSeconds'];
    dnsPolicy = data['dnsPolicy'];

    nodeSelector = {};
    if (data.containsKey('nodeSelector')) {
      (data['nodeSelector'] as Map<String, dynamic>)
          .forEach((key, value) => nodeSelector[key] = value);
    }

    serviceAccountName = data['serviceAccountName'];
    serviceAccount = data['serviceAccount'];
    nodeName = data['nodeName'];
    securityContext = null;
    if (data.containsKey('securityContext')) {
      securityContext = SecurityContext.fromMap(data['securityContext']);
    }
    schedulerName = data['schedulerName'];

    tolerations = [];
    if (data.containsKey('tolerations')) {
      for (Map<String, dynamic> e in data['tolerations']) {
        tolerations.add(Toleration.fromMap(e));
      }
    }

    priority = data['priority'];
    enableServiceLinks = data['enableServiceLinks'];
    preemptionPolicy = data['preemptionPolicy'];

    ports = [];
    if (data.containsKey('ports')) {
      for (Map<String, dynamic> e in data['ports']) {
        ports.add(Port.fromMap(e));
      }
    }

    clusterIP = data['clusterIP'];

    clusterIPs = [];
    if (data.containsKey('clusterIPs')) {
      for (String e in data['clusterIPs']) {
        clusterIPs.add(e);
      }
    }

    type = data['type'];
    sessionAffinity = data['sessionAffinity'];

    ipFamilies = [];
    if (data.containsKey('ipFamilies')) {
      for (String e in data['ipFamilies']) {
        ipFamilies.add(e);
      }
    }

    ipFamilyPolicy = data['ipFamilyPolicy'];
    internalTrafficPolicy = data['internalTrafficPolicy'];

    status = {};
    if (data.containsKey('status')) {
      for (Map<String, dynamic> e in data['status']) {
        for (var f in e.entries) {
          switch (f.key) {
            case 'loadBalancer':
              status[f.key] = LoadBalancerStatus.fromMap(f.value);
          }
        }
      }
    }

    template = {};
    if (data.containsKey('template')) {
      Template.fromMap(data['template']);
    }

    topologySpreadConstraints = [];
    if (data.containsKey('topologySpreadConstraints')) {
      for (Map<String, dynamic> e in data['topologySpreadConstraints']) {
        topologySpreadConstraints.add(TopologySpreadConstraint.fromMap(e));
      }
    }

    if (data.containsKey('strategy')) {
      strategy = Strategy.fromMap(data['strategy']);
    }

    revisionHistoryLimit = data['revisionHistoryLimit'];
    progressDeadlineSeconds = data['progressDeadlineSeconds'];

    selector = {};
    if (data.containsKey('selector')) {
      final e = Selector.fromMap(data['selector']);
      selector[e.type] = e;
    }
  }
}
