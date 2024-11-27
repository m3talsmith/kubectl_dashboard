import 'label_selector.dart';

class TopologySpreadConstraint {
  late LabelSelector labelSelector;
  late List<String> matchLabelKeys;
  late int maxSkew;
  late int minDomains;
  late String nodeAffinityPolicy;
  late String nodeTaintsPolicy;
  late String topologyKey;
  late String whenUnsatisfiable;

  TopologySpreadConstraint.fromMap(Map<String, dynamic> data) {
    labelSelector = LabelSelector.fromMap(data['labelSelector']);
    matchLabelKeys = data['matchLabelKeys'] as List<String>;
    maxSkew = data['maxSkew'];
    minDomains = data['minDomains'];
    nodeAffinityPolicy = data['nodeAffinityPolicy'];
    nodeTaintsPolicy = data['nodeTaintsPolicy'];
    topologyKey = data['topologyKey'];
    whenUnsatisfiable = data['whenUnsatisfiable'];
  }
}
