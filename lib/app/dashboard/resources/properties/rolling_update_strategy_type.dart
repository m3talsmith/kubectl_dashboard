import 'strategy_type.dart';

class RollingUpdateStrategyType implements StrategyType {
  dynamic maxUnavailable;
  dynamic maxSurge;

  RollingUpdateStrategyType.fromMap(Map<String, dynamic> data) {
    maxUnavailable = data['maxUnavailable'];
    maxSurge = data['maxSurge'];
  }
}
