import '../quantity.dart';

class EmptyDirVolumeSource {
  late String medium;
  late Quantity sizeLimit;

  EmptyDirVolumeSource.fromMap(Map<String, dynamic> data) {
    medium = data['medium'];
    sizeLimit = data['sizeLimit'] as Quantity;
  }
}
