class KeyToPath {
  String? key;
  int? mode;
  String? path;

  KeyToPath.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    mode = data['mode'];
    path = data['path'];
  }
}
