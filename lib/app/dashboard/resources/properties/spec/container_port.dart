class ContainerPort {
  late int containerPort;
  String? hostIP;
  int? hostPort;
  late String name;
  late String protocol;

  ContainerPort.fromMap(Map<String, dynamic> data) {
    containerPort = data['containerPort'];
    hostIP = data['hostIP'];
    hostPort = data['hostPort'];
    name = data['name'];
    protocol = data['protocol'];
  }
}
