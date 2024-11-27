import 'node_selector_term.dart';

class PreferredSchedulingTerm {
  late NodeSelectorTerm preference;
  late int weight;

  PreferredSchedulingTerm.fromMap(Map<String, dynamic> data) {
    preference = NodeSelectorTerm.fromMap(data['preference']);
    weight = data['weight'];
  }
}
