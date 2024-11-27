import '../quantity.dart';

class EmptyDirVolumeSource {
  String? medium;
  Quantity? sizeLimit;

  EmptyDirVolumeSource.fromMap(Map<String, dynamic> data) {
    medium = data['medium'];
    sizeLimit = data['sizeLimit'] as Quantity?;
  }
}
