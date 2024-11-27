import 'quantity.dart';

class ResourceFieldSelector {
  late String containerName;
  late Quantity divisor;
  late String resource;

  ResourceFieldSelector.fromMap(Map<String, dynamic> data) {
    containerName = data['containerName'];
    divisor = data['divisor'] as Quantity;
    resource = data['resource'];
  }
}
