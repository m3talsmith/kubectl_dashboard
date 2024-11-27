import 'managed_field_entry.dart';
import 'owner_reference.dart';

class ObjectMeta {
  late Map<String, dynamic> annotations;
  late DateTime creationTimestamp;
  late int deletionGracePeriodSeconds;
  late DateTime deletionTimestamp;
  late List<String> finalizers;
  late String generateName;
  late int generation;
  late Map<String, dynamic> labels;
  late List<ManagedFieldEntry> managedFields;
  late String name;
  late String namespace;
  late List<OwnerReference> ownerReferences;
  late String resourceVersion;
  late String selfLink;
  late String uid;

  ObjectMeta.fromMap(Map<String, dynamic> data) {
    annotations = {};
    for (var e in (data['annotations'] as Map<String, dynamic>).entries) {
      annotations[e.key] = e.value;
    }
    creationTimestamp = DateTime.parse(data['creationTimestamp']);
    deletionGracePeriodSeconds = data['deletionGracePeriodSeconds'];
    deletionTimestamp = DateTime.parse(data['deletionTimestamp']);
    finalizers = data['finalizers'] as List<String>;
    generateName = data['generateName'];
    generation = data['generation'];
    labels = {};
    for (var e in (data['labels'] as Map<String, dynamic>).entries) {
      labels[e.key] = e.value;
    }
    managedFields = (data['managedFields'] as List<Map<String, dynamic>>)
        .map(
          (e) => ManagedFieldEntry.fromMap(e),
        )
        .toList();
    name = data['name'];
    namespace = data['namespace'];
    ownerReferences = (data['ownerReferences'] as List<Map<String, dynamic>>)
        .map(
          (e) => OwnerReference.fromMap(e),
        )
        .toList();
    resourceVersion = data['resourceVersion'];
    selfLink = data['selfLink'];
    uid = data['uid'];
  }
}
