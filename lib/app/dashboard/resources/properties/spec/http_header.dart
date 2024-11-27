class HTTPHeader {
  late String name;
  late String value;

  HTTPHeader.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    value = data['value'];
  }
}
