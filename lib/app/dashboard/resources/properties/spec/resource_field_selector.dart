import 'quantity.dart';

class ResourceFieldSelector {
  String? containerName;
  dynamic divisor;
  String? resource;

  ResourceFieldSelector.fromMap(Map<String, dynamic> data) {
    containerName = data['containerName'];
    divisor = (data['divisor'] is String?)
        ? data['divisor']
        : data['divisor'] as Quantity?;
    resource = data['resource'];
  }
}
