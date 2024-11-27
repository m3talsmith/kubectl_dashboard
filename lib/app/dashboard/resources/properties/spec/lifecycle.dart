import 'lifecycle_handler.dart';

class Lifecycle {
  LifecycleHandler? postStart;
  LifecycleHandler? preStop;

  Lifecycle.fromMap(Map<String, dynamic> data) {
    if (data['postStart'] != null) {
      postStart = LifecycleHandler.fromMap(data['postStart']);
    }
    if (data['preStop'] != null) {
      preStop = LifecycleHandler.fromMap(data['preStop']);
    }
  }
}
