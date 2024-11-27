class KeyToPath {
  late String key;
  late int mode;
  late String path;

  KeyToPath.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    mode = data['mode'];
    path = data['path'];
  }
}
