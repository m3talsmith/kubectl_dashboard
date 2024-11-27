import 'node_selector_term.dart';

class NodeSelector {
  late List<NodeSelectorTerm> nodeSelectorTerms;

  NodeSelector.fromMap(Map<String, dynamic> data) {
    nodeSelectorTerms =
        (data['nodeSelectorTerms'] as List<Map<String, dynamic>>)
            .map(
              (e) => NodeSelectorTerm.fromMap(e),
            )
            .toList();
  }
}
