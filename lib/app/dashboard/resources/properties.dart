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
  late List<Volume> volumes;
  late List<Container> containers;
  late String restartPolicy;
  late int terminationGracePeriodSeconds;
  late String dnsPolicy;
  late Map<String, String> nodeSelector;
  late String serviceAccountName;
  late String serviceAccount;
  late String nodeName;
  late SecurityContext securityContext;
  late String schedulerName;
  late List<Toleration> tolerations;
  late int priority;
  late bool enableServiceLinks;
  late String preemptionPolicy;
}

class Volume {
  late String name;
  late Projected projected;
}

class Projected {
  late List<Source> sources;
  late int defaultMode;
}

abstract class Source {}

class ServiceAccountToken implements Source {
  late int expirationSeconds;
  late String path;
}

class ConfigMap implements Source {
  late String name;
  late List<ConfigMapItem> items;
}

class ConfigMapItem {
  late String key;
  late String path;
}

class DownwardAPI implements Source {
  late List<DownwardAPIItem> items;
}

class DownwardAPIItem {
  late String path;
  late FieldRef fieldRef;
}

class FieldRef {
  late String apiVersion;
  late String fieldPath;
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
}

class Port {
  late String name;
  late int containerPort;
  late String protocol;
}

class Env {
  late String name;
  late FieldRef valueFrom;
}

class VolumeMount {
  late String name;
  late bool readOnly;
  late String mountPath;
}

class SecurityContext {
  late Map<String, dynamic> capabilities;
  late bool allowPrivilegeEscalation;
  late bool runAsNonRoot;
  late Map<String, String> seccompProfile;
}

class Toleration {
  late String key;
  late String operator;
  late String effect;
  late int tolerationSeconds;
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
