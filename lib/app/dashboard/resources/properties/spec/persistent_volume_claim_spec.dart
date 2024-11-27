import 'label_selector.dart';
import 'resource_requirements.dart';
import 'typed_local_object_reference.dart';
import 'typed_object_reference.dart';

class PersistentVolumeClaimSpec {
  late List<String> accessModes;
  late TypedLocalObjectReference dataSource;
  late TypedObjectReference dataSourceRef;
  late ResourceRequirements resources;
  late LabelSelector selector;
  late String storageClassName;
  late String volumeMode;
  late String volumeName;

  PersistentVolumeClaimSpec.fromMap(Map<String, dynamic> data) {
    accessModes = data['accessModes'] as List<String>;
    dataSource = TypedLocalObjectReference.fromMap(data['dataSource']);
    dataSourceRef = TypedObjectReference.fromMap(data['dataSourceRef']);
    resources = ResourceRequirements.fromMap(data['resources']);
    selector = LabelSelector.fromMap(data['selector']);
    volumeMode = data['volumeMode'];
    volumeName = data['volumeName'];
  }
}
