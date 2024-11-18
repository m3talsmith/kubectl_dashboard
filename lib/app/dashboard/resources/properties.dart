import 'dart:developer';

class Metadata {
  Metadata();

  late String name;
  late String? generateName;
  late String namespace;
  late String uid;
  late String resourceVersion;
  late DateTime creationTimestamp;
  late Map<String, dynamic>? labels;
  late List<OwnerReference>? ownerReferences;
  late List<ManagedField>? managedFields;

  Metadata.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    generateName = data['generateName'];
    namespace = data['namespace'];
    uid = data['uid'];
    resourceVersion = data['resourceVersion'];
    creationTimestamp = DateTime.parse(data['creationTimestamp']);
    labels = data['labels'];
    ownerReferences = [];
    if (data.containsKey('ownerReferences')) {
      for (Map<String, dynamic> e in data['ownerReferences']) {
        ownerReferences!.add(OwnerReference.fromMap(e));
      }
    }

    managedFields = [];
    if (data.containsKey('managedFields')) {
      for (Map<String, dynamic> e in data['managedFields']) {
        managedFields!.add(ManagedField.fromMap(e));
      }
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

  late List<Volume> volumes;
  late List<Container> containers;
  late String? restartPolicy;
  late int? terminationGracePeriodSeconds;
  late String? dnsPolicy;
  late Map<String, String> nodeSelector;
  late String? serviceAccountName;
  late String? serviceAccount;
  late String? nodeName;
  late SecurityContext securityContext;
  late String? schedulerName;
  late List<Toleration> tolerations;
  late int? priority;
  late bool? enableServiceLinks;
  late String? preemptionPolicy;

  Spec.fromMap(Map<String, dynamic> data) {
    volumes = [];
    if (data.containsKey('volumes')) {
      for (Map<String, dynamic> e in data['volumes']) {
        volumes.add(Volume.fromMap(data));
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
      log('[DEBUG] nodeSelector: ${data['nodeSelector']}');
      // for (Map<String, String> e in data['nodeSelector']) {
      //   e.forEach((key, value) => nodeSelector[key] = value);
      // }
    }

    serviceAccountName = data['serviceAccountName'];
    serviceAccount = data['serviceAccount'];
    nodeName = data['nodeName'];
    if (data.containsKey('securityContext'))
      securityContext = SecurityContext.fromMap(data['securityContext']);
    schedulerName = data['schedulerName'];

    tolerations = [];
    if (data.containsKey('tolerations')) {
      log('[DEBUG] tolerations: ${data['tolerations']}');
      // for (Map<String, dynamic> e in data['tolerations']) {
      //   tolerations.add(Toleration.fromMap(e));
      // }
    }

    priority = data['priority'];
    enableServiceLinks = data['enableServiceLinks'];
    preemptionPolicy = data['preemptionPolicy'];
  }
}

class Volume {
  late String? name;
  late Projected? projected;

  Volume.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    if (data.containsKey('projected'))
      projected = Projected.fromMap(data['projected']);
  }
}

class Projected {
  late List<Source> sources;
  late int defaultMode;

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
      log('[DEBUG] resources: ${data['resources']}');
      // for (Map<String, dynamic> e in data['resources']) {
      //   e.forEach((key, value) => resources[key] = value);
      // }
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
    if (data.containsKey('securityContext'))
      securityContext = SecurityContext.fromMap(data['securityContext']);
  }
}

class Port {
  late String name;
  late int containerPort;
  late String protocol;

  Port.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    containerPort = data['containerPort'];
    protocol = data['protocol'];
  }
}

class Env {
  late String name;
  late FieldRef? valueFrom;

  Env.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    if (data.containsKey('valueFrom'))
      valueFrom = FieldRef.fromMap(data['valueFrom']);
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
      log('[DEBUG] capabilities: ${data['capabilities']}');
      // for (Map<String, dynamic> e in data['capabilities']) {
      //   e.forEach((key, value) => capabilities[key] = value);
      // }
    }
    allowPrivilegeEscalation = data['allowPrivilegeEscalation'];
    runAsNonRoot = data['runAsNonRoot'];
    seccompProfile = {};
    if (data.containsKey('seccompProfile')) {
      log('[DEBUG] seccompProfile: ${data['seccompProfile']}');
      // for (Map<String, String> e in data['seccompProfile']) {
      //   e.forEach((key, value) => seccompProfile[key] = value);
      // }
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
  late String phase;
  late List<Condition> conditions;
  late String hostIP;
  late List<Map<String, String>> hostIPs;
  late String podIP;
  late List<Map<String, String>> podIPs;
  late DateTime startTime;
  late List<ContainerStatus> containerStatuses;
  late String qosClass;
}

class Condition {
  late String type;
  late String status;
  late DateTime lastProbeTime;
  late DateTime lastTransitionTime;
}

class ContainerStatus {
  late String name;
  late Map<String, State> state;
  late Map<String, State> lastState;
  late bool running;
  late int restartCount;
  late String image;
  late String imageID;
  late String containerID;
  late bool started;
}

class State {
  late DateTime startedAt;
}
