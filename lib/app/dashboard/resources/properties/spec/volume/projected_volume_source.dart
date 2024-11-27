import 'volume_projection.dart';

class ProjectedVolumeSource {
  late int defaultMode;
  late List<VolumeProjection> sources;

  ProjectedVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    sources = (data['sources'] as List<Map<String, dynamic>>)
        .map(
          (e) => VolumeProjection.fromMap(e),
        )
        .toList();
  }
}
