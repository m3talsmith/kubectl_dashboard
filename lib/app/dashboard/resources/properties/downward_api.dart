import 'field_ref.dart';
import 'source.dart';

class DownwardAPI implements Source {
  late List<DownwardAPIItem> items;

  DownwardAPI.fromMap(Map<String, dynamic> data) {
    items = [];
    if (data.containsKey('items')) {
      for (Map<String, dynamic> e in data['items']) {
        items.add(DownwardAPIItem.fromMap(e));
      }
    }
  }
}

class DownwardAPIItem {
  late String path;
  late FieldRef fieldRef;

  DownwardAPIItem.fromMap(Map<String, dynamic> data) {
    path = data['path'];
    fieldRef = FieldRef.fromMap(data['fieldRef']);
  }
}
