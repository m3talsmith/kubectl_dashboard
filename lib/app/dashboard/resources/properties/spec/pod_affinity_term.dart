import 'label_selector.dart';

class PodAffinityTerm {
  late LabelSelector labelSelector;
  late LabelSelector namespaceSelector;
  late List<String> namespaces;
  late String topologyKey;

  PodAffinityTerm.fromMap(Map<String, dynamic> data) {
    labelSelector = LabelSelector.fromMap(data['labelSelector']);
    namespaceSelector = LabelSelector.fromMap(data['namespaceSelector']);
    namespaces = data['namespaces'] as List<String>;
    topologyKey = data['topologyKey'];
  }
}
