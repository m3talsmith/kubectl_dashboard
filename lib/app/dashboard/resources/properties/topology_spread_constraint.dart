import 'label_selector.dart';
import 'match_labels_label_selector.dart';

class TopologySpreadConstraint {
  late int maxSkew;
  late String topologyKey;
  late String whenUnsatisfiable;
  late Map<String, LabelSelector> labelSelector;

  TopologySpreadConstraint.fromMap(Map<String, dynamic> data) {
    maxSkew = data['maxSkew'];
    topologyKey = data['topologyKey'];
    whenUnsatisfiable = data['whenUnsatisfiable'];

    labelSelector = {};
    if (data.containsKey('labelSelector')) {
      for (var e in (data['labelSelector'] as Map<String, dynamic>).entries) {
        switch (e.key) {
          case 'matchLabels':
            labelSelector[e.key] = MatchLabelsLabelSelector.fromMap(e.value);
        }
      }
    }
  }
}
