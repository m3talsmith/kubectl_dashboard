class GRPCAction {
  late int port;
  late String service;

  GRPCAction.fromMap(Map<String, dynamic> data) {
    port = data['port'];
    service = data['service'];
  }
}
