import 'fields_v1.dart';

class ManagedFieldEntry {
  late String apiVersion;
  late String fieldsType;
  late FieldsV1 fieldsV1;
  late String manager;
  late String operation;
  late String subresource;
  late DateTime time;

  ManagedFieldEntry.fromMap(Map<String, dynamic> data) {
    apiVersion = data['apiVersion'];
    fieldsType = data['fieldsType'];
    fieldsV1 = data['fieldsV1'] as FieldsV1;
    manager = data['manager'];
    operation = data['operation'];
    subresource = data['subresource'];
    time = DateTime.parse(data['time']);
  }
}
