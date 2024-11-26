class Port {
  String? name;
  int? containerPort;
  String? protocol;
  dynamic targetPort;

  Port.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    containerPort = data['containerPort'];
    protocol = data['protocol'];
    targetPort = data['targetPort'];
  }
}
