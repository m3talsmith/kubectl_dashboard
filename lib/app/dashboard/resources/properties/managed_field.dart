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
