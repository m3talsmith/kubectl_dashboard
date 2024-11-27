import 'node_selector_requirement.dart';

class NodeSelectorTerm {
  late List<NodeSelectorRequirement> matchExpressions;
  late List<NodeSelectorRequirement> matchFields;

  NodeSelectorTerm.fromMap(Map<String, dynamic> data) {
    matchExpressions = (data['matchExpressions'] as List<Map<String, dynamic>>)
        .map(
          (e) => NodeSelectorRequirement.fromMap(e),
        )
        .toList();
    matchFields = (data['matchFields'] as List<Map<String, dynamic>>)
        .map(
          (e) => NodeSelectorRequirement.fromMap(e),
        )
        .toList();
  }
}
