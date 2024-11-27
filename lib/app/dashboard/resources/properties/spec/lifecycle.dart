import 'lifecycle_handler.dart';

class Lifecycle {
  late LifecycleHandler postStart;
  late LifecycleHandler preStop;

  Lifecycle.fromMap(Map<String, dynamic> data) {
    postStart = LifecycleHandler.fromMap(data['postStart']);
    preStop = LifecycleHandler.fromMap(data['preStop']);
  }
}
