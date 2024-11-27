import 'downward_api_volume_file.dart';

class DownwardAPIVolumeSource {
  late int defaultMode;
  late List<DownwardAPIVolumeFile> items;

  DownwardAPIVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    items = (data['items'] as List<Map<String, dynamic>>)
        .map(
          (e) => DownwardAPIVolumeFile.fromMap(e),
        )
        .toList();
  }
}
