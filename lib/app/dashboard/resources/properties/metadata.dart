import 'managed_field.dart';
import 'owner_reference.dart';

class Metadata {
  Metadata();

  late Map<String, dynamic> annotations;
  DateTime? creationTimestamp;
  int? deletionGracePeriodSeconds;
  DateTime? deletionTimestamp;
  late List<dynamic> finalizers;
  String? generateName;
  int? generation;
  late Map<String, dynamic> labels;
  late List<ManagedField> managedFields;
  String? name;
  String? namespace;
  late List<OwnerReference> ownerReferences;
  String? resourceVersion;
  String? selfLink;
  String? uid;

  Metadata.fromMap(Map<String, dynamic> data) {
    annotations = {};
    if (data.containsKey('annotations')) {
      annotations = data['annotations'];
    }

    if (data.containsKey('creationTimestamp') &&
        data['creationTimestamp'] != null) {
      creationTimestamp = DateTime.parse(data['creationTimestamp']);
    }

    deletionGracePeriodSeconds = data['deletionGracePeriodSeconds'];

    if (data.containsKey('deletionTimestamp')) {
      deletionTimestamp = DateTime.parse(data['deletionTimestamp']);
    }

    finalizers = [];
    if (data.containsKey('finalizers')) {
      finalizers = data['finalizers'];
    }

    generateName = data['generateName'];
    generation = data['generation'];

    labels = {};
    if (data.containsKey('labels')) {
      labels = data['labels'];
    }

    managedFields = [];
    if (data.containsKey('managedFields')) {
      for (Map<String, dynamic> e in data['managedFields']) {
        managedFields.add(ManagedField.fromMap(e));
      }
    }

    name = data['name'];
    namespace = data['namespace'];

    ownerReferences = [];
    if (data.containsKey('ownerReferences')) {
      for (Map<String, dynamic> e in data['ownerReferences']) {
        ownerReferences.add(OwnerReference.fromMap(e));
      }
    }

    resourceVersion = data['resourceVersion'];
    selfLink = data['selfLink'];
    uid = data['uid'];
  }
}
