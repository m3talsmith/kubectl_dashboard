import 'volume_projection.dart';

class ProjectedVolumeSource {
  int? defaultMode;
  List<VolumeProjection>? sources;

  ProjectedVolumeSource.fromMap(Map<String, dynamic> data) {
    defaultMode = data['defaultMode'];
    if (data['sources'] != null) {
      sources = [];
      for (var e in data['sources']) {
        sources!.add(VolumeProjection.fromMap(e));
      }
    }
  }
}
