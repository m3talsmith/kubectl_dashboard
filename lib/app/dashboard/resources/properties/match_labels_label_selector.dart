import 'label_selector.dart';

class MatchLabelsLabelSelector implements LabelSelector {
  late String k8sApp;

  MatchLabelsLabelSelector.fromMap(Map<String, dynamic> data) {
    k8sApp = data['k8s-app'];
  }
}
