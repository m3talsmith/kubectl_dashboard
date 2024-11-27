import 'label_selector_requirement.dart';

class LabelSelector {
  late List<LabelSelectorRequirement> matchExpressions;
  late Map<String, LabelSelectorRequirement> matchLabels;

  LabelSelector.fromMap(Map<String, dynamic> data) {
    matchExpressions = (data['matchExpressions'] as List<Map<String, dynamic>>)
        .map(
          (e) => LabelSelectorRequirement.fromMap(e),
        )
        .toList();
    matchLabels = {};
    for (var e in (data['matchLabels'] as Map<String, dynamic>).entries) {
      matchLabels[e.key] = LabelSelectorRequirement.fromMap(e.value);
    }
  }
}
