class TCPSocketAction {
  late String host;
  late dynamic port;

  TCPSocketAction.fromMap(Map<String, dynamic> data) {
    host = data['host'];
    port = data['port'];
  }
}
