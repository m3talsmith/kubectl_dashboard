import 'package:kubectl_dashboard/app/dashboard/resources/properties/spec/volume/downward_api_volume_file.dart';

class DownwardAPIProjection {
  late List<DownwardAPIVolumeFile> items;

  DownwardAPIProjection.fromMap(Map<String, dynamic> data) {
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => DownwardAPIVolumeFile.fromMap(e),
        )
        .toList();
  }
}
