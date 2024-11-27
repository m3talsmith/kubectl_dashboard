import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/volume/downward_api_volume_file.dart';

class DownwardAPIProjection {
  List<DownwardAPIVolumeFile>? items;

  DownwardAPIProjection.fromMap(Map<String, dynamic> data) {
    if (data['items'] != null) {
      items = [];
      for (var e in data['items']) {
        items!.add(DownwardAPIVolumeFile.fromMap(e));
      }
    }
  }
}
