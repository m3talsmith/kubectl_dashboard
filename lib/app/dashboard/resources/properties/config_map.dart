import 'source.dart';

class ConfigMap implements Source {
  late String name;
  late List<ConfigMapItem> items;
  int? defaultNode;
  bool? optional;

  ConfigMap.fromMap(Map<String, dynamic> data) {
    name = data['name'];

    items = [];
    if (data.containsKey('items')) {
      for (Map<String, dynamic> e in data['items']) {
        items.add(ConfigMapItem.fromMap(e));
      }
    }

    defaultNode = data['defaultNode'];
    optional = data['optional'];
  }
}

class ConfigMapItem {
  late String key;
  late String path;

  ConfigMapItem.fromMap(Map<String, dynamic> data) {
    key = data['key'];
    path = data['path'];
  }
}
