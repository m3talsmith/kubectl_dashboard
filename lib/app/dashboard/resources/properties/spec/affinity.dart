import 'node_selector.dart';
import 'pod_affinity_term.dart';
import 'preferred_scheduling_term.dart';
import 'weighted_pod_affinity_term.dart';

abstract class Affinity {}

class NodeAffinity implements Affinity {
  late List<PreferredSchedulingTerm>
      preferredDuringSchedulingIgnoredDuringExecution;
  late NodeSelector requiredDuringSchedulingIgnoredDuringExecution;

  NodeAffinity.fromMap(Map<String, dynamic> data) {
    preferredDuringSchedulingIgnoredDuringExecution =
        (data['preferredDuringSchedulingIgnoredDuringExecution']
                as List<Map<String, dynamic>>)
            .map(
              (e) => PreferredSchedulingTerm.fromMap(e),
            )
            .toList();
    requiredDuringSchedulingIgnoredDuringExecution = NodeSelector.fromMap(
        data['requiredDuringSchedulingIgnoredDuringExecution']);
  }
}

class PodAffinity implements Affinity {
  late List<WeightedPodAffinityTerm>
      preferredDuringSchedulingIgnoredDuringExecution;
  late List<PodAffinityTerm> requiredDuringSchedulingIgnoredDuringExecution;

  PodAffinity.fromMap(Map<String, dynamic> data) {
    preferredDuringSchedulingIgnoredDuringExecution =
        (data['preferredDuringSchedulingIgnoredDuringExecution']
                as List<dynamic>)
            .map(
              (e) => WeightedPodAffinityTerm.fromMap(e),
            )
            .toList();
    requiredDuringSchedulingIgnoredDuringExecution =
        (data['requiredDuringSchedulingIgnoredDuringExecution']
                as List<dynamic>)
            .map(
              (e) => PodAffinityTerm.fromMap(e),
            )
            .toList();
  }
}

class PodAntiAffinity implements Affinity {
  late List<WeightedPodAffinityTerm>
      preferredDuringSchedulingIgnoredDuringExecution;
  late List<PodAffinityTerm> requiredDuringSchedulingIgnoredDuringExecution;

  PodAntiAffinity.fromMap(Map<String, dynamic> data) {
    preferredDuringSchedulingIgnoredDuringExecution =
        (data['preferredDuringSchedulingIgnoredDuringExecution']
                as List<dynamic>)
            .map(
              (e) => WeightedPodAffinityTerm.fromMap(e),
            )
            .toList();
    requiredDuringSchedulingIgnoredDuringExecution =
        (data['requiredDuringSchedulingIgnoredDuringExecution']
                as List<dynamic>)
            .map(
              (e) => PodAffinityTerm.fromMap(e),
            )
            .toList();
  }
}
