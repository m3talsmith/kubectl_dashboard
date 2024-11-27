import 'exec_action.dart';
import 'grpc_action.dart';
import 'http_get_action.dart';
import 'tcp_socket_action.dart';

class Probe {
  ExecAction? exec;
  int? failureThreshold;
  GRPCAction? grpc;
  HTTPGetAction? httpGet;
  int? initialDelaySeconds;
  int? periodSeconds;
  int? successThreshold;
  TCPSocketAction? tcpSocket;
  int? terminationGracePeriodSeconds;
  int? timeoutSeconds;

  Probe.fromMap(Map<String, dynamic> data) {
    if (data['exec'] != null) {
      exec = ExecAction.fromMap(data['exec']);
    }
    failureThreshold = data['failureThreshold'];
    if (data['grpc'] != null) {
      grpc = GRPCAction.fromMap(data['grpc']);
    }
    if (data['httpGet'] != null) {
      httpGet = HTTPGetAction.fromMap(data['httpGet']);
    }
    initialDelaySeconds = data['initialDelaySeconds'];
    periodSeconds = data['periodSeconds'];
    successThreshold = data['successThreshold'];
    if (data['tcpSocket'] != null) {
      tcpSocket = TCPSocketAction.fromMap(data['tcpSocket']);
    }
    terminationGracePeriodSeconds = data['terminationGracePeriodSeconds'];
    timeoutSeconds = data['timeoutSeconds'];
  }
}
