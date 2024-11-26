import 'http_get.dart';

class Probe {
  HttpGet? httpGet;
  int? initialDelaySeconds;
  int? timeoutSeconds;
  int? periodSeconds;
  int? successThreshold;
  int? failureThreshold;

  Probe.fromMap(Map<String, dynamic> data) {
    if (data.containsKey('httpGet')) {
      httpGet = HttpGet.fromMap(data['httpGet']);
    }

    initialDelaySeconds = data['initialDelaySeconds'];
    timeoutSeconds = data['timeoutSeconds'];
    periodSeconds = data['periodSeconds'];
    successThreshold = data['successThreshold'];
    failureThreshold = data['failureThreshold'];
  }
}
