import 'rolling_update_strategy_type.dart';
import 'strategy_type.dart';

class Strategy {
  late String type;
  late StrategyType _details;

  Strategy.fromMap(Map<String, dynamic> data) {
    type = data['type'];
    switch (type) {
      case 'RollingUpdate':
        _details = RollingUpdateStrategyType.fromMap(data['rollingUpdate']);
    }
  }

  get details => _details;
}
