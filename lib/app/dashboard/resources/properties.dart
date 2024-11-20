class Metadata {
  Metadata();

  late String name;
  late String? generateName;
  late String namespace;
  late String uid;
  late String resourceVersion;
  late DateTime creationTimestamp;
  late Map<String, dynamic>? labels;
  late List<OwnerReference> ownerReferences;
  late List<ManagedField> managedFields;
  late Map<String, dynamic> annotations;
  late List<String> finalizers;

  Metadata.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    generateName = data['generateName'];
    namespace = data['namespace'];
    uid = data['uid'];
    resourceVersion = data['resourceVersion'];
    creationTimestamp = DateTime.parse(data['creationTimestamp']);

    labels = {};
    if (data.containsKey('labels')) {
      labels = data['labels'];
    }

    ownerReferences = [];
    if (data.containsKey('ownerReferences')) {
      for (Map<String, dynamic> e in data['ownerReferences']) {
        ownerReferences.add(OwnerReference.fromMap(e));
      }
    }

    managedFields = [];
    if (data.containsKey('managedFields')) {
      for (Map<String, dynamic> e in data['managedFields']) {
        managedFields.add(ManagedField.fromMap(e));
      }
    }

    annotations = {};
    if (data.containsKey('annotations')) {
      annotations = data['annotations'];
    }

    finalizers = [];
    if (data.containsKey('finalizers')) {
      finalizers = data['finalizers'];
    }
  }
}

class OwnerReference {
  late String apiVersion;
  late String kind;
  late String name;
  late String uid;
  late bool controller;
  late bool blockOwnerDeletion;

  OwnerReference.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    name = data['name'];
    kind = data['kind'];
    uid = data['uid'];
    controller = data['controller'];
    blockOwnerDeletion = data['blockOwnerDeletion'];
  }
}

class ManagedField {
  late String manager;
  late String operation;
  late String apiVersion;
  late DateTime time;
  late String subresource;

  ManagedField.fromMap(Map<String, dynamic> data) {
    manager = data['manager'];
    operation = data['operation'];
    apiVersion = data['apiVersion'];
    time = DateTime.parse(data['time']);
    subresource = data.containsKey('subresource') ? data['subresource'] : '';
  }
}

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
  Map<String, dynamic>? selector;
  late Map<String, ServiceStatus> status;

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
  }
}

class Volume {
  String? name;
  Projected? projected;

  Volume.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    if (data.containsKey('projected')) {
      projected = Projected.fromMap(data['projected']);
    }
  }
}

class Projected {
  late List<Source> sources;
  int? defaultMode;

  Projected.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('sources')) {
      sources = [];
      for (Map<String, dynamic> e in data['sources']) {
        final key = e.keys.first;
        final value = e.values.first;
        switch (key) {
          case ('serviceAccountToken'):
            sources.add(ServiceAccountToken.fromMap(value));
          case ('configMap'):
            sources.add(ConfigMap.fromMap(value));
          case ('downwardAPI'):
            sources.add(DownwardAPI.fromMap(value));
        }
      }
    }
  }
}

abstract class Source {}

class ServiceAccountToken implements Source {
  late int expirationSeconds;
  late String path;

  ServiceAccountToken.fromMap(Map<String, dynamic> data) {
    expirationSeconds = data['expirationSeconds'];
    path = data['path'];
  }
}

class ConfigMap implements Source {
  late String name;
  late List<ConfigMapItem> items;

  ConfigMap.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    items = [];
    if (data.containsKey('items')) {
      for (Map<String, dynamic> e in data['items']) {
        items.add(ConfigMapItem.fromMap(e));
      }
    }
  }
}

class ConfigMapItem {
  late String key;
  late String path;

  ConfigMapItem.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    path = data['path'];
  }
}

class DownwardAPI implements Source {
  late List<DownwardAPIItem> items;

  DownwardAPI.fromMap(Map<String, dynamic> data) {
    items = [];
    if (data.containsKey('items')) {
      for (Map<String, dynamic> e in data['items']) {
        items.add(DownwardAPIItem.fromMap(e));
      }
    }
  }
}

class DownwardAPIItem {
  late String path;
  late FieldRef fieldRef;

  DownwardAPIItem.fromMap(Map<String, dynamic> data) {
    path = data['path'];
    fieldRef = FieldRef.fromMap(data['fieldRef']);
  }
}

class FieldRef {
  late String? apiVersion;
  late String? fieldPath;

  FieldRef.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    fieldPath = data['fieldPath'];
  }
}

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
  }
}

class Port {
  late String name;
  late int containerPort;
  late String protocol;
  int? targetPort;

  Port.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    containerPort = data['containerPort'];
    protocol = data['protocol'];
    targetPort = data['targetPort'];
  }
}

class Env {
  late String name;
  late FieldRef? valueFrom;

  Env.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    if (data.containsKey('valueFrom')) {
      valueFrom = FieldRef.fromMap(data['valueFrom']);
    }
  }
}

class VolumeMount {
  late String? name;
  late bool? readOnly;
  late String? mountPath;

  VolumeMount.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    readOnly = data['readOnly'];
    mountPath = data['mountPath'];
  }
}

class SecurityContext {
  late Map<String, dynamic> capabilities;
  late bool? allowPrivilegeEscalation;
  late bool? runAsNonRoot;
  late Map<String, String> seccompProfile;

  SecurityContext.fromMap(Map<String, dynamic> data) {
    capabilities = {};
    if (data.containsKey('capabilities')) {
      (data['capabilities'] as Map<String, dynamic>)
          .forEach((key, value) => capabilities[key] = value);
    }
    allowPrivilegeEscalation = data['allowPrivilegeEscalation'];
    runAsNonRoot = data['runAsNonRoot'];
    seccompProfile = {};
    if (data.containsKey('seccompProfile')) {
      (data['seccompProfile'] as Map<String, dynamic>)
          .forEach((key, value) => seccompProfile[key] = value);
    }
  }
}

class Toleration {
  late String? key;
  late String? operator;
  late String? effect;
  late int? tolerationSeconds;

  Toleration.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    operator = data['operator'];
    effect = data['effect'];
    tolerationSeconds = data['tolerationSeconds'];
  }
}

class Status {
  String? phase;
  late List<Condition> conditions;
  String? hostIP;
  late List<Map<String, String>> hostIPs;
  String? podIP;
  late List<Map<String, String>> podIPs;
  DateTime? startTime;
  late List<ContainerStatus> containerStatuses;
  String? qosClass;

  Status.fromMap(Map<String, dynamic> data) {
    phase = data['phase'];

    conditions = [];
    if (data.containsKey('conditions')) {
      for (Map<String, dynamic> e in data['conditions']) {
        conditions.add(Condition.fromMap(e));
      }
    }

    hostIP = data['hostIP'];
    hostIPs = [];
    if (data.containsKey('hostIPs')) {
      for (Map<String, dynamic> e in (data['hostIPs'] as List<dynamic>)) {
        final Map<String, String> h = {};
        e.forEach((key, value) => h[key] = value);
        hostIPs.add(h);
      }
    }

    podIP = data['podIP'];
    podIPs = [];
    if (data.containsKey('podIPs')) {
      for (Map<String, dynamic> e in (data['podIPs'] as List<dynamic>)) {
        final Map<String, String> p = {};
        e.forEach((key, value) => p[key] = value);
        podIPs.add(p);
      }
    }

    if (data.containsKey('startTime')) {
      startTime = DateTime.parse(data['startTime']);
    }

    containerStatuses = [];
    if (data.containsKey('containerStatuses')) {
      for (Map<String, dynamic> e in data['containerStatuses']) {
        containerStatuses.add(ContainerStatus.fromMap(e));
      }
    }

    qosClass = data['qosClass'];
  }
}

abstract class ServiceStatus {}

class LoadBalancerStatus implements ServiceStatus {
  late Map<String, InternalStatus> statuses;

  LoadBalancerStatus.fromMap(Map<String, dynamic> data) {
    for (var e in data.entries) {
      switch (e.key) {
        case 'ingress':
          statuses[e.key] = IngressInternalStatus.fromMap(e.value);
      }
    }
  }
}

abstract class InternalStatus {}

class IngressInternalStatus implements InternalStatus {
  late String ip;
  late String ipMode;

  IngressInternalStatus.fromMap(Map<String, dynamic> data) {
    ip = data['ip'];
    ipMode = data['ipMode'];
  }
}

class Condition {
  late String type;
  late String status;
  late DateTime? lastProbeTime;
  late DateTime? lastTransitionTime;

  Condition.fromMap(Map<String, dynamic> data) {
    type = data['type'];
    status = data['status'];
    lastProbeTime =
        (data.containsKey('lastProbeTime') && data['lastProbeTime'] != null)
            ? DateTime.parse(data['lastProbeTime'])
            : null;
    if (data.containsKey('lastTransitionTime')) {
      lastTransitionTime = DateTime.parse(data['lastTransitionTime']);
    }
  }
}

class ContainerStatus {
  late String name;
  late Map<String, State> state;
  late Map<String, State> lastState;
  bool? running;
  int? restartCount;
  String? image;
  String? imageID;
  String? containerID;
  bool? started;

  ContainerStatus.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    state = (data['state'] as Map<String, dynamic>)
        .entries
        .fold(<String, State>{}, (previousValue, element) {
      previousValue[element.key] = State.fromMap(element.value);
      return previousValue;
    });
    lastState = (data['lastState'] as Map<String, dynamic>)
        .entries
        .fold(<String, State>{}, (previousValue, element) {
      previousValue[element.key] = State.fromMap(element.value);
      return previousValue;
    });
    running = data['running'];
    restartCount = data['restartCount'];
    image = data['image'];
    imageID = data['imageID'];
    containerID = data['containerID'];
    started = data['started'];
  }
}

class State {
  late DateTime startedAt;

  State.fromMap(Map<String, dynamic> data) {
    startedAt = DateTime.parse(data['startedAt']);
  }
}
