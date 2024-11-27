class HostAlias {
  late List<String> hostnames;
  late String ip;

  HostAlias.fromMap(Map<String, dynamic> data) {
    hostnames = data['hostnames'] as List<String>;
    ip = data['ip'];
  }
}
